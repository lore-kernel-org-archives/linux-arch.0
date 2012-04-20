From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v6 6/6] keys: kill task_struct->replacement_session_keyring
Date: Fri, 20 Apr 2012 09:45:43 +0100
Message-ID: <10250.1334911543@redhat.com>
References: <20120419231616.GF15828@redhat.com> <20120419231431.GA15820@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120419231616.GF15828@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alexander Gordeev <agordeev@redhat.com>, Chris Zankel <chris@zankel.net>, David Smith <dsmith@redhat.com>, "Frank Ch. Eigler" <fche@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Larry Woodman <lwoodman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Kuo <rkuo@codeaurora.org>, Tejun Heo <tj@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Oleg Nesterov <oleg@redhat.com> wrote:

> Kill the no longer used task_struct->replacement_session_keyring,
> update copy_creds() and exit_creds().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: David Howells <dhowells@redhat.com>
