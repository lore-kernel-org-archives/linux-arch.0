Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp02.citrix.com ([66.165.176.63]:39789 "EHLO
	SMTP02.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbbAOKno (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Jan 2015 05:43:44 -0500
Message-ID: <54B799DC.1050008@citrix.com>
Date: Thu, 15 Jan 2015 10:43:40 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 3/8] x86/xen/p2m: Replace ACCESS_ONCE with
 READ_ONCE
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com> <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com>
In-Reply-To: <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20150115104340.61iXSNmuKOmxI6F473aki0gfhqG2y_twXCC8X8iGRd4@z>

On 15/01/15 08:58, Christian Borntraeger wrote:
> ACCESS_ONCE does not work reliably on non-scalar types. For
> example gcc 4.6 and 4.7 might remove the volatile tag for such
> accesses during the SRA (scalar replacement of aggregates) step
> (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
> 
> Change the p2m code to replace ACCESS_ONCE with READ_ONCE.

Acked-by: David Vrabel <david.vrabel@citrix.com>

Let me know if you want me to merge this via the Xen tree.

David
