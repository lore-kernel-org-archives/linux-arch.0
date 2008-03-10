Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbYCJMJo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 10 Mar 2008 08:09:44 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200803100913.m2A9DJYM009298@imap1.linux-foundation.org>
References: <200803100913.m2A9DJYM009298@imap1.linux-foundation.org>
Subject: Re: + kvm-provide-kvmh-for-all-architecture-fixes-headers_install.patch added to -mm tree
Date: Mon, 10 Mar 2008 12:08:37 +0000
Message-ID: <10680.1205150917@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: dhowells@redhat.com, mm-commits@vger.kernel.org, borntraeger@de.ibm.com, avi@qumranet.com, dwmw2@infradead.org, linux-arch@vger.kernel.org, sam@ravnborg.org
Message-ID: <20080310120837.J-ZTV6Ei8INN5NQxnK_O2V4fXXjg7mg6N06YAiEoSAo@z>

akpm@linux-foundation.org wrote:

> diff -puN /dev/null include/asm-frv/kvm.h
> --- /dev/null
> +++ a/include/asm-frv/kvm.h
> @@ -0,0 +1,6 @@
> +#ifndef __LINUX_KVM_FRV_H
> +#define __LINUX_KVM_FRV_H
> +
> +/* cris does not support KVM */

That may be so, but this is an FRV header file, not CRIS.

David
