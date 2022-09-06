extends Area2D

var move = false
var speed = 64
var horizontalSpeed = 30
var target = Vector2(100,-2)
var verticalSpeed
var g = 9.81
var need_dir

func _ready():
#	need_dir = self.position.direction_to(target)
#	var dis = self.position.distance_to(target) #计算2个物体间距离
#	var need_time = dis / speed/2 #公式
#	verticalSpeed = g * need_time #计算出垂直上的初速度
	pass
	
func _process(delta):
	if move:# 抛物线公式 标准方程 y^2 = 2px  x^2 = 2py
		# 重力加速度 h=½gt²
		verticalSpeed = verticalSpeed - g * delta #垂直上的初速度随时间的改变
		var vertical = verticalSpeed  # 垂直上的运动
		var horizon = need_dir.x * speed * delta # 水平上的运动
		self.translate(Vector2(vertical,horizon))
		# 笨办法
#		if self.position.x < 100:
#			translate(Vector2(speed,-speed)*delta)
#		else:
#			translate(Vector2(speed,speed)*delta)
	pass


func _on_ShouLiuDan_body_entered(body):
	if body.type == "Enemy":
		if is_instance_valid(body):
			body.hurt()
		queue_free()
	pass
#定点抛物线的实现
#让我们回忆一下初中学得最基本的物理知识
#1: S=Vt 距离等于速度x时间(用于抛物线中水平运动)
#2: V=at 速度等于加速度x时间(用于抛物线垂直运动)
# unity 抛物线
"""
public class Parabolic : MonoBehaviour {
	public float horizontalSpeed = 30f;//水平上的速度,自己定义
	public Transform target; //目标点
	public float verticalSpeed; //垂直上的初速度
	public float g = 9.81; //重力加速度
	public Vector3 need_direction; //当前物体指向目标物体的方向
	void Start () {
		dis = Vector3.Distance(transform.position,target.position);//计算2个物体间距离
		need_direction = (target.position - transform.position).normalized;//获得当前物体指向目标物体的方向
		float need_time = dis / speed/2f;//公式
		verticalSpeed = g * need_time;//计算出垂直上的初速度
	}
	void FixedUpdate () {
			verticalSpeed = verticalSpeed - g * Time.fixedDeltaTime;//垂直上的初速度随时间的改变
			transform.Translate(need_direction* speed * Time.fixedDeltaTime, Space.World);//水平上的运动
			transform.Translate(Vector3.up * verticalSpeed * Time.fixedDeltaTime, Space.World);//垂直上的运动
	}
}
"""
