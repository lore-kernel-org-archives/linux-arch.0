Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34496 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760860Ab2EJRiM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 May 2012 13:38:12 -0400
Received: by gglu4 with SMTP id u4so1105415ggl.19
        for <linux-arch@vger.kernel.org>; Thu, 10 May 2012 10:38:11 -0700 (PDT)
Message-ID: <4FABFCFE.8010307@landley.net>
Date: Thu, 10 May 2012 12:38:06 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Subject: Re: [PATCH] bitops: add _local bitops
References: <20120509134528.GA18044@redhat.com>
In-Reply-To: <20120509134528.GA18044@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org
Message-ID: <20120510173806.wdNhz4LITifS13OeaJVgd48P6pxgdTYfoPiQPsMeFWY@z>

On 05/09/2012 08:45 AM, Michael S. Tsirkin wrote:
> diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
> index 27f2b21..b7e3b67 100644
> --- a/Documentation/atomic_ops.txt
> +++ b/Documentation/atomic_ops.txt
> @@ -520,6 +520,25 @@ The __clear_bit_unlock version is non-atomic, however it still implements
>  unlock barrier semantics. This can be useful if the lock itself is protecting
>  the other bits in the word.
>  
> +Local versions of the bitmask operations are also provided.  They are used in
> +contexts where the operations need to be performed atomically with respect to
> +the local CPU, but no other CPU accesses the bitmask.  This assumption makes it
> +possible to avoid the need for SMP protection and use less expensive atomic
> +operations in the implementation.
> +They have names similar to the above bitmask operation interfaces,
> +except that _local is sufficed to the interface name.
> +
> +	void set_bit_local(unsigned long nr, volatile unsigned long *addr);
> +	void clear_bit_local(unsigned long nr, volatile unsigned long *addr);
> +	void change_bit_local(unsigned long nr, volatile unsigned long *addr);
> +	int test_and_set_bit_local(unsigned long nr, volatile unsigned long *addr);
> +	int test_and_clear_bit_local(unsigned long nr, volatile unsigned long *addr);
> +	int test_and_change_bit_local(unsigned long nr, volatile unsigned long *addr);
> +
> +These local variants are useful for example if the bitmask may be accessed from
> +a local intrerrupt, or from a hypervisor on the same CPU if running in a VM.
> +These local variants also do not have any special memory barrier semantics.
> +
>  Finally, there are non-atomic versions of the bitmask operations
>  provided.  They are used in contexts where some other higher-level SMP
>  locking scheme is being used to protect the bitmask, and thus less

For this bit:

Acked-by: Rob Landley <rob@landley.net>

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
