# encoding: utf-8
#
# Rake task to import dali editor into vish

#PATHS
DALI_EDITOR_PLUGIN_PATH = "lib/plugins/dali_editor"
DALI_EDITOR_PATH = "../dali"


######################
# 			REGEXP       #
######################
#API
REGEX_SAVE = "http://127.0.0.1:8081/saveConfig"
REGEX_GET =  "http://127.0.0.1:8081/getConfig"
REGEX_API_PLUGIN = 'plugins/"'

#INDEX
REGEX_LIB = 'src\="lib'
REGEX_BASEPLUGIN = 'src\="BasePlugin.js"'
REGEX_BASEPLUGINVISOR = 'src\="BasePluginVisor.js"'
REGEX_PLUGINS = 'src\="plugins.js"'
REGEX_BUNDLE = 'src\="bundle.js"'
REGEX_CSS = 'href\="css/textStyles.css"'
REGEX_CAJASCOLOR = 'href\="css/pluginsCss/cajascolor.css"'
REGEX_ANIM_VERT_CSS = 'href\="css/pluginsCss/jquery-animVert.css"'

REGEX_DIST = '/lib/visor/dist.zip'
REGEX_INDEXEJS = '/lib/visor/index.ejs'
REGEX_PAGEEJS = '/lib/visor/page.ejs'
REGEX_SCORM = '/lib/scorm/scorm.zip'

#IMAGES
REGEX_IMAGES_SRC = 'src\="images'
REGEX_IMAGES_SRC2 = '\.\./images'
REGEX_IMAGES_PLAIN = 'images/'

######################
# 	PATHS REWRITES   #
######################

#API
SAVE_URL_DALI = "url"
GET_URL_DALI = "url"
PATH_API_PLUGIN = '\/assets/plugins/"'

#INDEX
PATH_LIB = 'src\=\"/assets/lib'
PATH_EDITOR_BP = 'src\=\"/assets/editor/BasePlugin.js"'
PATH_EDITOR_BPV = 'src\=\"/assets/editor/BasePluginVisor.js"'
PATH_PLUGINS = 'src\=\"/assets/editor/plugins.js"'
PATH_BUNDLE = 'src\=\"/assets/editor/bundle.js"'
PATH_CSS_TEXTSTYLES = 'href\=\"/assets/dali_documents/textStyles.css"'
PATH_CAJASCOLOR = 'href\=\"/assets/dali_documents/pluginsCss/cajascolor.css"'
PATH_ANIM_VERT_CSS = 'href\=\"/assets/dali_documents/pluginsCss/jquery-animVert.css"'

PATH_DIST = "/assets/lib/visor/dist.zip"
PATH_INDEXEJS = "/assets/lib/visor/index.js"
PATH_PAGEEJS = "/assets/lib/visor/page.js"
PATH_SCORM = "/assets/lib/scorm/scorm.zip"

#IMAGES
PATH_IMAGES_SRC = 'src\="/assets/images'
PATH_IMAGES_SRC2 = '/assets/images'
PATH_IMAGES_PLAIN = '/assets/images/'


namespace :dali_editor do

	task :rebuild do
		Rake::Task["dali_editor:import"].invoke
    	Rake::Task["dali_editor:rewrite_api_paths"].invoke
    	Rake::Task["dali_editor:rewrite_localization_paths"].invoke
    	Rake::Task["dali_editor:rewrite_images_paths"].invoke
    	Rake::Task["dali_editor:rewrite_visor_path"].invoke
	end

	task :import do
		puts "Importing Dali into VISH"

		system "rm -rf " + DALI_EDITOR_PLUGIN_PATH + "/app"
		system "rm -rf " + DALI_EDITOR_PLUGIN_PATH + "/extras"

		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/assets"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/images"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/stylesheets"
				system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/stylesheets/dali_documents"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/views"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents"
		system "mkdir " + DALI_EDITOR_PLUGIN_PATH + "/extras"

		system "cp -r " + DALI_EDITOR_PATH + "/dist/images " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/images"
		system "cp -r " + DALI_EDITOR_PATH + "/dist/css/. " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/stylesheets/dali_documents"
		system "cp -r " + DALI_EDITOR_PATH + "/dist/lib " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts"
		system "cp -r " + DALI_EDITOR_PATH + "/dist/plugins " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/plugins"
		system "cp " + DALI_EDITOR_PATH + "/dist/BasePlugin.js " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor"
		system "cp " + DALI_EDITOR_PATH + "/dist/BasePluginVisor.js " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor"
		system "cp " + DALI_EDITOR_PATH + "/dist/bundle.js " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor"



		#system "cp " + DALI_EDITOR_PATH + "/dist/dist.zip " +  DALI_EDITOR_PLUGIN_PATH + "/extras/dist.zip"
		system "cp " + DALI_EDITOR_PATH + "/dist/index.html " +  DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		#WE RENAME EJS FILES BECAUSE RAILS DOESNT KNOW HOW TO HANDLE THEM XD
		system "mv " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.ejs " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "mv " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/page.ejs " +  DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/page.js"
	end

	task :rewrite_api_paths do
		system "sed -i 's#" + REGEX_SAVE+ "#" + SAVE_URL_DALI + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor/bundle.js"
		system "sed -i 's#" + REGEX_GET+ "#" + GET_URL_DALI + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor/bundle.js"
		system "sed -i 's#" + REGEX_API_PLUGIN+ "#" + PATH_API_PLUGIN + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/api.js"
		system "sed -i 's#" + REGEX_API_PLUGIN+ "#" + PATH_API_PLUGIN + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/plugins.js"
	end

	task :rewrite_localization_paths do

		#REWRITE INDEX.HTML.ERB
		system "sed -i 's#" + REGEX_LIB+ "#" + PATH_LIB + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_BASEPLUGIN+ "#" + PATH_EDITOR_BP + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_BASEPLUGINVISOR+ "#" + PATH_EDITOR_BPV + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_PLUGINS+ "#" + PATH_PLUGINS + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_BUNDLE+ "#" + PATH_BUNDLE + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_CSS+ "#" + PATH_CSS_TEXTSTYLES + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_CAJASCOLOR+ "#" + PATH_CAJASCOLOR + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
		system "sed -i 's#" + REGEX_ANIM_VERT_CSS+ "#" + PATH_ANIM_VERT_CSS + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/views/dali_documents/_dali_document.full.erb"
	end

	task :rewrite_images_paths do
		system "sed -i 's#" + REGEX_IMAGES_SRC+ "#" + PATH_IMAGES_SRC + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "sed -i 's#" + REGEX_IMAGES_SRC+ "#" + PATH_IMAGES_SRC + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/visorbackup.js"
		system "sed -i 's#" + REGEX_IMAGES_SRC2+ "#" + PATH_IMAGES_SRC2 + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/stylesheets/dali_documents/textStyles.css"
		system "sed -i 's#" + REGEX_IMAGES_PLAIN+ "#" + PATH_IMAGES_PLAIN + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/editor/bundle.js"
	end

	task :rewrite_visor_path do
		system "sed -i 's#" + REGEX_LIB+ "#" + PATH_LIB + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "sed -i 's#" + REGEX_BASEPLUGIN+ "#" + PATH_EDITOR_BP + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "sed -i 's#" + REGEX_BASEPLUGINVISOR+ "#" + PATH_EDITOR_BPV + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "sed -i 's#" + REGEX_PLUGINS+ "#" + PATH_PLUGINS + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "sed -i 's#" + REGEX_BUNDLE+ "#" + PATH_BUNDLE + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"
		system "sed -i 's#" + REGEX_CSS+ "#" + PATH_CSS_TEXTSTYLES + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/index.js"

		system "sed -i 's#" + REGEX_DIST+ "#" + PATH_DIST + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/visor.js"
		system "sed -i 's#" + REGEX_INDEXEJS+ "#" + PATH_INDEXEJS + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/visor.js"
		system "sed -i 's#" + REGEX_PAGEEJS+ "#" + PATH_PAGEEJS + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/visor/visor.js"

		system "sed -i 's#" + REGEX_SCORM + "#" + PATH_SCORM + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/scorm/scorm.js"
		system "sed -i 's#" + REGEX_INDEXEJS+ "#" + PATH_INDEXEJS + "#g' " + DALI_EDITOR_PLUGIN_PATH + "/app/assets/javascripts/lib/scorm/scorm.js"
	end
end
