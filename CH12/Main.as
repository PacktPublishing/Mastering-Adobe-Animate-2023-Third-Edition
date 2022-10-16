package {
	import flash.display.MovieClip;
	import flash.filesystem.File;
	import fl.controls.DataGrid;
	import fl.data.DataProvider;
	import fl.containers.UILoader;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.FileListEvent;

	public class Main extends MovieClip {
		var photoDirectory: File;
		var photos: Array;
		var photoGridProvider: DataProvider;

		public function Main() {
			ChooseFolder.addEventListener(MouseEvent.CLICK, chooseDirectory);
			PhotoGrid.addEventListener(Event.CHANGE, photoSelected);
			PhotoGrid.columns = ["Name", "Type", "Size"];
			photos = new Array();
			photoGridProvider = new DataProvider();
			PhotoGrid.dataProvider = photoGridProvider;
		}

		private function chooseDirectory(e: MouseEvent): void {
			photoDirectory = new File();
			photoDirectory.addEventListener(Event.SELECT, directorySelected);
			photoDirectory.browseForDirectory("Select Photo Folder...");
		}

		private function directorySelected(e: Event): void {
			photoDirectory.getDirectoryListingAsync();
			photoDirectory.addEventListener(FileListEvent.DIRECTORY_LISTING, directoryListed);
		}

		private function directoryListed(e: FileListEvent): void {
			photos = new Array();
			for (var p: uint = 0; p < e.files.length; p++) {
				if (e.files[p].extension == "jpg" || e.files[p].extension == "png" || e.files[p].extension == "gif") {
					photos.push(e.files[p]);
				}
			}
			photoGridProvider.removeAll();
			for (var i: uint = 0; i < photos.length; i++) {
				photoGridProvider.addItem({
					"Name": photos[i].name,
					"Type": photos[i].extension,
					"Size": photos[i].size
				});
			}
		}

		private function photoSelected(e: Event): void {
			var selectedPhoto: File = photos[e.target.selectedIndex];
			PhotoViewer.source = selectedPhoto.url;
		}

	}
}