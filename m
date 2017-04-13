From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 10/27] pci: Add pci_mmap_resource_range() and use it for ARM64
Date: Thu, 13 Apr 2017 10:22:43 +0100
Message-ID: <16527.1492075363@warthog.procyon.org.uk>
References: <7ca58472ed9ff750fd1b7432b1738573e782290b.1491999859.git.dwmw2@infradead.org> <cover.1491999859.git.dwmw2@infradead.org> <cover.1491999859.git.dwmw2@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755606AbdDMJWp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Apr 2017 05:22:45 -0400
In-Reply-To: <7ca58472ed9ff750fd1b7432b1738573e782290b.1491999859.git.dwmw2@infradead.org>
Content-ID: <16526.1492075363.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: dhowells@redhat.com, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:

> +	vma->vm_pgoff += (pci_resource_start(pdev, bar) >> PAGE_SHIFT);
> +        vma->vm_ops = &pci_phys_vm_ops;

Whitespace error.

David
