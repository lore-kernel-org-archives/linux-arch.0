From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 00/10] tools: Revamp the unaligned endian access functions
Date: Tue, 10 Jun 2014 16:13:04 -0700
Message-ID: <1402441994-16780-1-git-send-email-hpa@zytor.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

After a recent problem in the x86 tree, which seems to be the heaviest
but not the only user of these functions, I went through and did a
patchset to revamp the *user space* unaligned/endian accessor
functions.  As much as I think it is downright pathetic that this
functionality still isn't part of the C standard, that is life and we
have to deal with it.  Furthermore, although glibc has a pretty nice
set of functions for byte swapping in <endian.h>, taken from FreeBSD I
believe, some older systems don't support them.

This variant tries to fill in all the holes.  It assumes that
<endian.h> define the functions as macros if they exist, as I don't
know any other way of probing for them without reaching for autoconf,
but that should be valid enough of an assumption in this case.

The hope is that this should give reasonable, if not optimal, code
generation on most processors, and give a hook where arch maintainers
can add their own changes if needed.
