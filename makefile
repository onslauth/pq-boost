include $(PQ_FACTORY)/factory.mk

pq_part_name := boost_1_57_0
pq_part_file := $(pq_part_name).tar.bz2

pq_boost_configuration_flags += --prefix=$(part_dir)
pq_boost_configuration_flags += --with-python-root=$(pq-python-dir)
pq_boost_configuration_flags += --with-python-version=2.7

build-stamp: stage-stamp
	cd $(pq_part_name) && BZIP2_INCLUDE=$(pq-bzip2-dir)/include BZIP2_LIBPATH=$(pq-bzip2-dir)/lib ./b2 --prefix=$(stage_dir)/$(part_dir) install
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	$(call show_vars,CFLAGS CPPFLAGS)
	cd $(pq_part_name) && ./bootstrap.sh $(pq_boost_configuration_flags)
	touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file)
	touch $@
