From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 20/40] mn10300: Use set_current_blocked() and block_sigmask()
Date: Tue, 14 Feb 2012 18:30:10 +0000
Message-ID: <28189.1329244210@redhat.com>
References: <1329242378.3675.71.camel@mfleming-mobl1.ger.corp.intel.com> <1329219673-28711-21-git-send-email-matt@console-pimps.org> <1329219673-28711-1-git-send-email-matt@console-pimps.org> <17603.1329234976@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1329242378.3675.71.camel@mfleming-mobl1.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-am33-list@redhat.com
List-Id: linux-arch.vger.kernel.org


Matt Fleming <matt@console-pimps.org> wrote:

> > Can this line create a race, now that it's not protected by a lock?  It is
> > possible for current->blocked to get altered by another thread.
> 
> ->blocked can only ever be altered by current, not another thread. See
> the following comment from sigprocmask() in kernel/signal.c,

Okay, I've managed to convince myself.  Feel free to my Acked-by to the
MN10300 and FRV patches.

David
