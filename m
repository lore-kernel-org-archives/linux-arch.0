From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V4 1/2] mm: Update generic gup implementation to handle
 hugepage directory
Date: Sat, 01 Nov 2014 14:05:54 -0400 (EDT)
Message-ID: <20141101.140554.427928361730485371.davem@davemloft.net>
References: <1414570785-18966-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1414570785-18966-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
To: aneesh.kumar@linux.vnet.ibm.com
Cc: akpm@linux-foundation.org, steve.capper@linaro.org, aarcange@redhat.com, benh@kernel.crashing.org, mpe@ellerman.id.au, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 29 Oct 2014 13:49:44 +0530

> +/*
> + * Some architectures requires a hugepage directory format that is
> + * required to support multiple hugepage sizes. For example
> + * a4fe3ce7699bfe1bd88f816b55d42d8fe1dac655 introduced the same
> + * on powerpc. This allows for a more flexible hugepage pagetable
> + * layout.
> + */

Please don't put commit IDs into the actual code.

If that commit gets backported to -stable or another tree, then this
comment will send someone on a wild goose chase.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
