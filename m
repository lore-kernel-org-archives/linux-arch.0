Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:25817 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265964AbUGZUiq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jul 2004 16:38:46 -0400
Date: Mon, 26 Jul 2004 13:36:38 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: compat_clock_getres shouldn't return -EFAULT if res == NULL
Message-Id: <20040726133638.46294dcb.akpm@osdl.org>
In-Reply-To: <20040726125553.7f8502be.davem@redhat.com>
References: <410560C1.1060804@intel.com>
	<20040726125553.7f8502be.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: arun.sharma@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

"David S. Miller" <davem@redhat.com> wrote:
>
> On Mon, 26 Jul 2004 12:51:29 -0700
> Arun Sharma <arun.sharma@intel.com> wrote:
> 
> > Description within the patch.
> 
> Looks good.

I'll queue it up.  I seem to have ~200 patches to deal with, mostly
non-trivial :(
