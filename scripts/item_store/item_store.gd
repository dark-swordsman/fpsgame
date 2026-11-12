class_name ItemStore extends Resource

var items: Dictionary[String, Item]

enum AddStatus { SUCCESS, FAIL_UNSPECIFIED }
enum RemoveStatus { SUCCESS, NOT_FOUND }

# an item manager may be created on every new start, but
# it's actual data may be loaded separately, like
# from the disk

func generate_unique_id() -> String:
	var uuid: String = UUID.new().as_string()
	# this might explode, we will see
	# verify a unique ID in the context of the item store
	while find_item_by_id(uuid):
		uuid = UUID.new().as_string()
	return uuid

func create_item(props: Dictionary[String, Variant]) -> Item:
	# null may break this
	props.id = generate_unique_id()
	var item: Item = Item.new(props)
	add_item_to_store(item)
	return item

# should just be private??
func add_item_to_store(item: Item) -> AddStatus:
	var result: bool = items.set(item.id, item)
	if result:
		return AddStatus.SUCCESS
	else:
		return AddStatus.FAIL_UNSPECIFIED
		
func remove_item_from_store(instance_id: String) -> RemoveStatus:
	var result: bool = items.erase(instance_id)
	if result:
		return RemoveStatus.SUCCESS
	else:
		return RemoveStatus.NOT_FOUND

func find_item_by_id(instance_id: String) -> Item:
	return items.get(instance_id)

func get_count() -> int:
	return items.keys().size()
