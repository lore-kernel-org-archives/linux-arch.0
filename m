Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx1-ext.sgi.com ([192.48.179.11]:57807 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030488AbWASBUT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 18 Jan 2006 20:20:19 -0500
Date: Wed, 18 Jan 2006 17:19:53 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: new syscalls
In-Reply-To: <20060118133629.1cda96fd.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0601181716520.3217@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F05737A9F@scsmsx401.amr.corp.intel.com>
 <20060118133629.1cda96fd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, JANAK DESAI <janak@us.ibm.com>, Ulrich Drepper <drepper@redhat.com>, David Woodhouse <dwmw2@infradead.org>, David Howells <dhowells@redhat.com>, Davide Libenzi <davidel@xmailserver.org>, Christoph Lameter <christoph@lameter.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 18 Jan 2006, Andrew Morton wrote:

> Guys, architecture maintainers need test suites to verify that the syscalls
> actually work as they wire them up.  Please share.  A stable URL would be
> preferred - something which can go into the changlog or conceivably into
> the kernel source.

sys_migrate_pages will be supported by libnuma in Andi Kleen's numactl 
package. There is no URL that I am aware of.
