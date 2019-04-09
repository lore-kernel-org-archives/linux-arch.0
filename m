From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: CONFIG_* symbols in UAPI headers?
Date: Tue, 09 Apr 2019 21:11:44 +0200
Message-ID: <10ca99831556bed2849e16caa5a4810628dc320c.camel@tiscali.nl>
References: <20190408124640.GA607@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408124640.GA607@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Jie Zhang <jie.zhang@analog.com>
Cc: Mike Frysinger <vapier@gentoo.org>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Christoph Hellwig schreef op ma 08-04-2019 om 14:46 [+0200]:
> There are a few similar issues, like struct elf_prstatus having
> a different layout depending on CONFIG_BINFMT_ELF_FDPIC, or
> MAX_SHARED_LIBS defending on CONFIG_BINFMT_SHARED_FLAT.

I've had the patch pasted below in a local branch for over five years, but
never dared to push it upstream.

Does it still apply?

Thanks,


Paul Bolle 

-- >8 ---
From 0f73c8ee776c197e3029c4eed21af0f121a8f9d3 Mon Sep 17 00:00:00 2001
From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 4 Feb 2014 22:22:48 +0100
Subject: [PATCH] headers_check: enable check for CONFIG_ leakage

The check for leaked CONFIG_ symbols was disabled in v2.6.30, because it
generated too much noise. But a (rather simplistic) preprocessing of
comments suffices to silence the noise (ie, no false positives are
reported anymore).

So add some preprocessing of comments and enable check_config() again.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 scripts/headers_check.pl | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/scripts/headers_check.pl b/scripts/headers_check.pl
index b6aec5e4365f..8e67017c1b67 100755
--- a/scripts/headers_check.pl
+++ b/scripts/headers_check.pl
@@ -36,13 +36,36 @@ foreach my $file (@files) {
 	open(my $fh, '<', $filename)
 		or die "$filename: $!\n";
 	$lineno = 0;
+	my $in_comment = 0;
+	my $swap_state = 0;
 	while ($line = <$fh>) {
 		$lineno++;
-		&check_include();
-		&check_asm_types();
-		&check_sizetypes();
-		&check_declarations();
-		# Dropped for now. Too much noise &check_config();
+
+		# strip inline comments
+		$line =~ s|/\*.*\*/||;
+
+		# try to handle multi line comments
+		if ($in_comment == 0 and $line =~ m|/\*|) {
+			$line =~ s|/\*.*$||;
+			# we still need to check (the first half of) this line
+			# so we set $in_comment after the checks
+			$swap_state = 1;
+		}
+		if ($in_comment == 1 and $line =~ m|\*/|) {
+			$line =~ s|^.*\*/||;
+			$in_comment = 0;
+		}
+		unless ($in_comment) {
+			check_include();
+			check_asm_types();
+			check_sizetypes();
+			check_declarations();
+			check_config();
+		}
+		if ($swap_state)  {
+			$in_comment = 1;
+			$swap_state = 0;
+		}
 	}
 	close $fh;
 }
-- 
2.17.2
