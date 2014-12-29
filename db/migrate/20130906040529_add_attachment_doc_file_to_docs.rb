class AddAttachmentDocFileToDocs < ActiveRecord::Migration
  def self.up
    change_table :docs do |t|
      t.attachment :doc_file
    end
  end

  def self.down
    drop_attached_file :docs, :doc_file
  end
end
