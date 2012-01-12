From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] kconfig: untangle EXPERT and EMBEDDED
Date: Thu, 12 Jan 2012 13:06:51 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1201121259270.17287@chino.kir.corp.google.com>
References: <1326295008-29795-1-git-send-email-drjones@redhat.com> <alpine.DEB.2.00.1201111353330.21755@chino.kir.corp.google.com> <201201120918.53026.arnd@arndb.de> <20120112101805.GA2375@turtle.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120112101805.GA2375@turtle.usersys.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jones <drjones@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, mingo@elte.hu, david.woodhouse@intel.com, gregkh@suse.de, davem@davemloft.net, axboe@kernel.dk, holt@sgi.com, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, hskinnemoen@gmail.com, egtvedt@samfundet.no, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, takata@linux-m32r.org, geert@linux-m68k.org, yasutake.koichi@jp.panasonic.com, jonas@southpole.se, kyle@mcmartin.ca, deller@gmx.de, jejb@parisc-linux.org, chris@zankel.net, greg@kroah.com, davej@redhat.com, airlied@linux.ie, jkosina@suse.cz, mchehab@infradead.org, johannes@sipsolutions.net, linville@tuxdriver.com
List-Id: linux-arch.vger.kernel.org

On Thu, 12 Jan 2012, Andrew Jones wrote:

> No, I'm putting EMBEDDED back to work doing the same thing it did before,
> i.e. the semantics for it are the same as they were before 6a108a14fa35.

Wrong, CONFIG_EMBEDDED actually had very loosely defined semantics prior 
ot 6a108a14fa35 (the renaming of CONFIG_EMBEDDED to CONFIG_EXPERT) which 
is why it was renamed in the first place.  Instead of being used solely 
for embedded devices, as you would suspect given its name and the reason 
it was introduced, it was hijacked to be used for any config option that 
was atypical for normal admins to disable and thus considered to be 
"expert" since it required a deeper level of understanding than enabling 
and disabling options at first glance or what is considered to be 
standard.  Those are two very different semantics.

> This is not a revert of that patch though. I'm keeping EXPERT, but
> ensuring it doesn't do everything EMBEDDED used to do. I'm ensuring it
> only does what it advertises it does, which is to give a useful configmenu
> cleanup symbol to the whole kernel.
> 

You're ignoring backwards compatibility for users who have already enabled 
CONFIG_EXPERT and have not enabled CONFIG_EMBEDDED (EXPERT does not select 
EMBEDDED, EMBEDDED selects EXPERT).  So if you're losing options that are 
currently configurable with CONFIG_EXPERT unless those users now enable 
CONFIG_EMBEDDED again, it's a non-starter.
