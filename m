From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 14/27] mn10300: Use generic pci_mmap_resource_range()
Date: Thu, 13 Apr 2017 10:22:03 +0100
Message-ID: <16480.1492075323@warthog.procyon.org.uk>
References: <15683b749605aa5e6733a587d495a8eab596f0e8.1491999859.git.dwmw2@infradead.org> <cover.1491999859.git.dwmw2@infradead.org> <cover.1491999859.git.dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751490AbdDMJWF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Apr 2017 05:22:05 -0400
In-Reply-To: <15683b749605aa5e6733a587d495a8eab596f0e8.1491999859.git.dwmw2@infradead.org>
Content-ID: <16479.1492075323.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dhowells@redhat.com, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This was setting vma->vm_flags |= VM_LOCKED. Not sure why...
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
