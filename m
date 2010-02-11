From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 0/2] Blackfin: use generic ptrace_resume code
Date: Thu, 11 Feb 2010 04:43:07 -0500
Message-ID: <1265881389-26925-1-git-send-email-vapier@gentoo.org>
References: <20100202185907.GE3630@lst.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100202185907.GE3630@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-arch.vger.kernel.org

These are the changes I'm going to be pushing out for 2.6.34.  They aren't
trivial to rebase, so I'm keeping them in my tree rather than pushing as
part of set through another.  They aren't dependent on anything pending
anyways (seem to work fine on top of 2.6.32.x).
