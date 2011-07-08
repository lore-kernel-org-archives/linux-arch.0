From: David Howells <dhowells@redhat.com>
Subject: [PATCH [ver #2] 03/39] UAPI: Add script to audit drivers/gpu/ for
 #including system headers with "..."
Date: Fri, 08 Jul 2011 15:23:17 +0100
Message-ID: <20110708142317.31344.62300.stgit@warthog.procyon.org.uk>
References: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750959Ab1GHOX4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Jul 2011 10:23:56 -0400
In-Reply-To: <20110708142244.31344.24941.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rdunlap@xenotime.net, hpa@kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, ralf@linux-mips.org

Add a script to audit drivers/gpu/ for #include "..." referring to system
headers and change them to <...>.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 scripts/uapi-disintegration/drm-headers.pl |  105 ++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100755 scripts/uapi-disintegration/drm-headers.pl

diff --git a/scripts/uapi-disintegration/drm-headers.pl b/scripts/uapi-disintegration/drm-headers.pl
new file mode 100755
index 0000000..09ba790
--- /dev/null
+++ b/scripts/uapi-disintegration/drm-headers.pl
@@ -0,0 +1,105 @@
+#!/usr/bin/perl -w
+
+use File::Find;
+
+#
+# Changes must be committed first
+#
+system("git diff --quiet") == 0 or die "Uncommitted changes; aborting\n";
+
+#
+# Delete the old patch under StGIT
+#
+system("stg delete uapi-convert-drivers_gpu-includes.diff");
+
+#
+# Set up the patch under StGIT
+#
+system("stg new -m '" .
+       "UAPI: Convert #include \"...\" to #include <path/...> in kernel system headers\n" .
+       "\n" .
+       "Convert #include \"...\" to #include <path/...> in kernel system headers.\n" .
+       "\n" .
+       "scripts/uapi-disintegrate/drm-headers.pl was used\n" .
+       "\n" .
+       "Signed-off-by: David Howells <dhowells\@redhat.com>\n" .
+       "' uapi-convert-drivers_gpu-includes.diff"
+    ) == 0 or die;
+
+#
+# Find all the .c and .h files under drivers/gpu/
+#
+%files = ();
+sub find_file()
+{
+    $files{$File::Find::name} = 1 if ($_ =~ /[.][ch]$/);
+}
+
+find(\&find_file, "drivers/gpu");
+
+#print join("\n", sort keys %files), "\n";
+
+foreach my $file (sort keys %files) {
+    my $dir = $file;
+    $dir =~ m@(^.*/)@, $dir = $1;
+
+    open FD, '<', $file or die "open $file: $!\n";
+    my @lines = <FD>;
+    close FD or die;
+
+    my $printed_name = 0;
+    my $alter_file = 0;
+
+    for (my $l = 0; $l <= $#lines; $l++) {
+	my $line = $lines[$l];
+
+	if ($line =~ /^(#\s*include\s+)["]([^"]+)["](.*[\n])/) {
+	    my $pre = $1;
+	    my $name = $2;
+	    my $post = $3;
+
+	    # If the included file really is in this directory, then "..." is
+	    # correct.
+	    next if (-f $dir.$2);
+
+	    if (!$printed_name) {
+		print "[[[ \e[36m$file\e[m ]]]\n";
+		$printed_name = 1;
+	    }
+
+	    my $path = "??";
+
+	    if ($name =~ m@[.][.]@) {
+		die;
+	    } else {
+		# Look in the system include paths for it
+		if (-f "include/$name") {
+		    $path = $name;
+		} elsif (-f "include/drm/$name") {
+		    $path = "drm/$name";
+		} else {
+		    die;
+		}
+	    }
+
+	    print $file, ": ", $name, " -> ", $path, "\n";
+	    $lines[$l] = $pre . "<" . $path . ">" . $post;
+	    $alter_file = 1;
+	}
+    }
+
+    if ($alter_file) {
+	my $temp = $file . ".drminc";
+	open FD, '>', $temp or die "create $temp: $!\n";
+	print FD @lines or die "write $temp: $!\n";
+	close FD or die "close $temp: $!\n";
+	rename $temp, $file or die "move $temp -> $file: $!\n";
+    }
+}
+
+#
+# Commit the changes
+#
+system("stg ref") == 0 or die;
+
+exit 0;
