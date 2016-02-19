From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC v2 1/7] sections.h: add sections header to collect all
 section info
Date: Fri, 19 Feb 2016 13:25:22 -0800
Message-ID: <20160219212522.GC3991@kroah.com>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
 <1455889559-9428-2-git-send-email-mcgrof@kernel.org>
 <20160219162329.GA24924@kroah.com>
 <20160219200603.GR25240@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46501 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426961AbcBSVZX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Feb 2016 16:25:23 -0500
Content-Disposition: inline
In-Reply-To: <20160219200603.GR25240@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org, luto@amacapital.net, boris.ostrovsky@oracle.com, rusty@rustcorp.com.au, david.vrabel@citrix.com, konrad.wilk@oracle.com, mcb30@ipxe.org, jgross@suse.com, ming.lei@canonical.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, benh@kernel.crashing.org, jbaron@akamai.com, ananth@in.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, masami.hiramatsu.pt@hitachi.com, andriy.shevchenko@linux.intel.com, dwmw2@infradead.org, xen-devel@lists.xensource.com

On Fri, Feb 19, 2016 at 09:06:03PM +0100, Luis R. Rodriguez wrote:
> On Fri, Feb 19, 2016 at 08:23:29AM -0800, Greg KH wrote:
> > On Fri, Feb 19, 2016 at 05:45:53AM -0800, Luis R. Rodriguez wrote:
> > > + * Due to this file being licensed under the GPL there is controversy over
> > > + * whether this permits you to write a module that #includes this file
> > > + * without placing your module under the GPL.  Please consult a lawyer for
> > > + * advice before doing this.
> > 
> > Interesting wording, 
> 
> This was copied from security.h. 

Ah, and look, I wrote that, nevermind then :)

sorry for the noise,

greg k-h
