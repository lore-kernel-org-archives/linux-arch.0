From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH 3/8] x86/xen/p2m: Replace ACCESS_ONCE with
 READ_ONCE
Date: Thu, 15 Jan 2015 10:43:40 +0000
Message-ID: <54B799DC.1050008@citrix.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com> <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421312314-72330-4-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, kvm-ppc@vger.kernel.org, linux-mm@kvack.org, xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

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
