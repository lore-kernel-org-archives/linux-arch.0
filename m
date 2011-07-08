From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 32/39] UAPI: Add a script to create a commit to set
 up new UAPI dirs
Date: Fri, 08 Jul 2011 15:28:07 +0100
Message-ID: <20110708142806.31344.68890.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34790 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab1GHO2s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:28:48 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Add a script to create and set up new UAPI dirs and then commit them to GIT or
StGIT:

	scripts/uapi-disintegration/set-up-Kbuild.pl

Signed-off-by: David Howells <dhowells@redhat.com>
---

 scripts/uapi-disintegration/set-up-Kbuild.pl |  108 ++++++++++++++++++++++++++
 1 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100755 scripts/uapi-disintegration/set-up-Kbuild.pl

diff --git a/scripts/uapi-disintegration/set-up-Kbuild.pl b/scripts/uapi-disintegration/set-up-Kbuild.pl
new file mode 100755
index 0000000..f81af83
--- /dev/null
+++ b/scripts/uapi-disintegration/set-up-Kbuild.pl
@@ -0,0 +1,108 @@
+#!/usr/bin/perl -w
+
+use File::Find;
+use File::Path;
+use strict;
+
+my @sys_header_dirs = (
+    "include"
+    );
+
+#
+# Changes must be committed first
+#
+system("git diff --quiet") == 0 or die "Uncommitted changes; aborting\n";
+
+#
+# Delete the old patch under StGIT
+#
+system("stg delete uapi-set-up-Kbuild.diff");
+
+#
+# Set up the patch under StGIT
+#
+system("stg new -m '" .
+       "UAPI: Set up UAPI Kbuild files\n" .
+       "\n" .
+       "Set up empty UAPI Kbuild files to be populated by the header splitter using\n" .
+       "scripts/uapi-disintegrate/set-up-Kbuild.pl\n" .
+       "\n" .
+       "Signed-off-by: David Howells <dhowells\@redhat.com>\n" .
+       "' uapi-set-up-Kbuild.diff"
+    ) == 0 or die;
+
+#
+# Find all the system header directories under arch
+#
+opendir DIR, "arch" or die;
+push @sys_header_dirs,
+    map { "arch/$_/include"; }
+sort grep { -d "arch/$_/include"; }
+grep { $_ !~ /^[.]/ }
+readdir DIR;
+closedir DIR;
+
+#
+# Find all the header files
+#
+my %kbuilds = ();
+sub find_Kbuild()
+{
+    $kbuilds{$File::Find::name} = 1 if ($_ =~ /Kbuild$/);
+}
+
+find(\&find_Kbuild, @sys_header_dirs);
+
+#print join("\n", sort keys %kbuilds), "\n";
+
+foreach my $kbuild (sort grep { $_ !~ m@arch/um/@} keys %kbuilds) {
+
+    my $uapi_kbuild = $kbuild;
+    $uapi_kbuild =~ s@include/@include/uapi/@;
+
+    print "[[[ $uapi_kbuild ]]]\n";
+
+    open FD, '<', $kbuild or die "open $kbuild: $!\n";
+    my @old = <FD>;
+    close FD or die;
+
+    my @new = ();
+
+    if ($#old > -1) {
+	if ($old[0] =~ /^#/) {
+	    for (my $l = 0; $l <= $#old; $l++) {
+		last if ($old[$l] !~ /^#/);
+		push @new, $old[$l];
+	    }
+	    push @new, "\n";
+	}
+
+	push @new, map {
+	    my $x = $_;
+	    $x =~ s@include/@include/uapi/@;
+	    $x;
+	} grep { $_ =~ m@^include@; } @old;
+
+	push @new, "\n" if ($#new > -1);
+
+	push @new, grep { $_ =~ m@header-y\s+[+]=\s+[a-z0-9A-Z-]+/\s*@; } @old;
+    }
+
+    #print @new;
+
+    my $uapidir = $uapi_kbuild;
+    $uapidir = $1 if ($uapidir =~ m!(.*)/!);
+    mkpath($uapidir) if (! -d $uapidir);
+
+    open FD, '>', $uapi_kbuild or die "create $uapi_kbuild: $!\n";
+    print FD @new or die "write $uapi_kbuild: $!\n";
+    close FD or die "close $uapi_kbuild: $!\n";
+    system("stg add $uapi_kbuild") == 0 or die;
+}
+
+#
+# Commit the changes
+#
+system("stg ref") == 0 or die;
+
+exit 0;
