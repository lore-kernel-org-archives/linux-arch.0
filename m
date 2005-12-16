Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 16 Dec 2005 23:13:06 GMT
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 0/12]: MUTEX: Introduce mutex implementation
Message-Id: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This set of patches implements mutexes as an alternative to semaphores where
such more restricted behaviour is appropriate.

There are several changes that might be appropriate to these patches:

 (1) Name DECLARE_MUTEX as DEFINE_MUTEX in linux/mutex-*.h

 (2) Make mutex_trylock()'s return value consistent with semaphores rather
     than everything else.

 (3) Drop the testing module (patch 12/12). I'm not sure I've got the plumbing
     correct in the master makefile.

Patches to come after Christmas will include sem -> completion conversions and
sem -> mutex conversions.

Merry Christmas!

David
