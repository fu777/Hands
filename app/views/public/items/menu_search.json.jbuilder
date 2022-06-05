json.array! @childrens do |child|
  json.id child.id
  json.name child.name
end
json.array! @parents do |parent|
  json.parent parent.parent_id
end
