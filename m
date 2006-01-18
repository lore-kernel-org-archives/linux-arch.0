Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:47278 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964926AbWARVhd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 16:37:33 -0500
Date: Wed, 18 Jan 2006 13:36:29 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: new syscalls
Message-Id: <20060118133629.1cda96fd.akpm@osdl.org>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>, David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> > Various new syscalls which are trickling their way Linuswards and will need
> > testing and wiring up once they get there:
> 
> Are there test-suites for any/all of these new calls?
> 

That's an excellent point.

Guys, architecture maintainers need test suites to verify that the syscalls
actually work as they wire them up.  Please share.  A stable URL would be
preferred - something which can go into the changlog or conceivably into
the kernel source.

Thanks.
