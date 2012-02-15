From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 00/40] arch: set_current_blocked() and block_sigmask()
Date: Wed, 15 Feb 2012 11:47:53 +0000
Message-ID: <1329306473.3675.113.camel@mfleming-mobl1.ger.corp.intel.com>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
	 <20120214173220.GB22645@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120214173220.GB22645@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2012-02-14 at 18:32 +0100, Oleg Nesterov wrote:
> On 02/14, Matt Fleming wrote:
> >
> > This series simplifies the architecture code for handling signals by
> > making use of set_current_blocked() introduced in e6fa16ab ("signal:
> > sigprocmask() should do retarget_shared_pending()") and
> > block_sigmask() introduced in commit 5e6292c0f28f ("signal: add
> > block_sigmask() for adding sigmask to current->blocked").
> 
> Matt, I assume this series was not changed since we discussed it ?

Correct. The only new additions are the C6X and hexagon patches here,

	https://lkml.org/lkml/2012/2/14/123
	https://lkml.org/lkml/2012/2/14/155

But they're pretty much the same as all the others in the series.

> If yes. I do not want to spam lkml, I'll reply to 0/40 only.
> 
> All patches look right to me, for the whole series:
> 
> Acked-by: Oleg Nesterov <oleg@redhat.com>

Great, thanks!

-- 
Matt Fleming, Intel Open Source Technology Center
