Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FB1E487;
	Fri,  6 Mar 2026 00:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772755422; cv=none; b=f2je87p3233fAZDysZwkmJWxcpnfMoZOUgfzcK3oj0Zhqs8PUiynrfPtRT8uasORf1ne4YflNIyy7gCxK1Fh7f450H/NsrafZ2KEfZSEL3OTJgqnSOO2UfMVNViIZNmzvhqzea9upPoyPDY5KmH2uH2NofdJDcXpssnZy5d21GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772755422; c=relaxed/simple;
	bh=nrC7I1PmhGqsvRiK2y30B1oIdgxc+fAZLzf1P7VwXgM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=og9acD24op34CYrJNoKdKoaLVragi5D0R2YFsb64JI/9Lo5QonvRqNUCHozfWJMDWwXxmJePEtNnEMR+BNp+4YH3hGkFDQMtBpN8+iyxxKiaKsxrE8OSurf/+oika7pkZtEhIUrg9HUy6xOj+QdFCK81S9M0FnkoG5hPZtyZA0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2kdvCI1d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2kdvCI1d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=tukeidjJ3uXl3SUBZ43S7vYev5NKZHJb1PtkiqnEDf4=; b=2kdvCI1d237Oc2y/6CvKIRMdr3
	lA8OJ6pCErD1LH7PCR/sob+S096MH7dW0h4dN7e1GhBoXQNacZR6Eg0Kr1/tc07iWbHER5gAPVlCj
	s+abjSG/qRlNDoUl4K6XufAH3CJPZiKenzn7ngbcLLUxWTb6b+odOqMneBFBABGbTWB8IOFDwRPIn
	5eYKQFbgXrw6Ix0GW9VrjCixelCSdCO+9hgVIZwFl+GW3uaFqacMmQks9yTYP16k2iNoVXixrTLiy
	B64lJMtsY+Q5mCNYAlMAd1lREjp9s7gMArzDlm2Y90QgpnckZYUEgZ1jlEGdb989jMJpmfEZ3A96S
	SrBGqPkw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyIfK-00000002lTV-2qSl;
	Fri, 06 Mar 2026 00:03:38 +0000
Message-ID: <fda0c5d3-bf7e-400f-9829-2c9e22224221@infradead.org>
Date: Thu, 5 Mar 2026 16:03:37 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mqueue: introduce new do_mq_timedreceive2() [ mq_peek
 syscall] for non-destructive receive and inspection,fix minor issue,prepared
 doc.
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk
References: <20260305180942.913686-1-academic1mathura@gmail.com>
Content-Language: en-US
In-Reply-To: <20260305180942.913686-1-academic1mathura@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/5/26 10:09 AM, Mathura_Kumar wrote:
> First of all Thanks for constructive response,I am  new to kernel development
> so in earlier patch has some style issue
> 

That ^^^ should be in a cover letter or below the "---" line,
The Subject: should say [PATCH v2].
This (following) list of changes from v1 to v2 should also be
below the "---" line and not part of the patch description.
For v3, leave the v1->v2 changes and add v2->v3 changes, etc.

> what changed now:-
> 
> 1)As per my estimate all style issue fixed
> 2)Doc was prepared in Documentation/userspace-api/syscall.rst, for better
>  consistency, i was not making inline comment for doc in source code
> 3)I am squashing  previous three commit in this latest one for convenience  in applying
>   and merging
> 
> Required Attention:-As per mail from bot
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on shuah-kselftest/next]
> [also build test ERROR on shuah-kselftest/fixes next-20260304]
> [cannot apply to arnd-asm-generic/master linus/master tip/x86/asm v6.16-rc1]
> 
> As per my guess bot failed to apply all earlier patch in order,now As Squashed,
> it should not come but if it then required manual intervention, I tested Successfully
> on x86-64 bit host arch for x86-64,arm64,risc-v  and all test.
> 
> some note:-macro and header guard are extermally sensetive for order of sys call number

                                        extremely sensitive

> on risc-v ,after of hour testing ,hit and trail and i fix that
> 
> Short Description:
> 
>     POSIX message queues currently lack a mechanism to read
>     a message without removing it from the queue. This is a
>     long-standing limitation,when we require inspection of queue state
>     without altering it.
> 
>     Modifying existing mq_receive() semantics via additional
>     flags was considered. However, altering behavior of an
>     existing syscall risks breaking backward compatibility
>     for applications relying on current semantics. Since
>     mq_receive() guarantees message removal, changing this
>     contract is not safe.
> 
>     To preserve ABI stability, this patch introduces a new
>     system call that performs a non-destructive receive
>     operation (peek). The existing behavior remains unchanged.
> 
>     Design considerations:
> 
>     Two approaches for copying message data to userspace
>     were evaluated:
> 
>     1) Refcount-based message lifecycle handling
>        - This can help us  Avoids intermediate temp kernel copy
>        - Extends message lifetime
>        -But this may increase writer starvation under heavy load and
>         add unneassery complication on priority  management and

	      unnecessary

>         delay more time to free space in inode due refcount may prevent
> 
>     2) Temporary kernel buffer copy
>        - Copies message into a bounded kernel buffer
>        - Reduces time message remains locked
>        - Improves fairness under write-heavy workloads
>        - Simpler lifetime management
> 
>     My implementation adopts the temporary buffer approach
>     to minimize starvation and reduce locking complexity.
>     The design allows future transition if refcounting is
>     deemed preferable.
> 
>     Architecture support: ALL
> 
>     Testing:
>       - 15+ functional test cases
>       - Multi-threaded producer/consumer scenarios
>       - concurrent pop and peek
>       - Edge cases: empty queue, FIFO
>         invalid flags, signal interruption etc.

Is there a use case or user for this syscall?
If so, please describe it (or them) here.

> 
> Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
>
> ---

> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index a68b1bea57a8..119f820a5a1d 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -22,6 +22,7 @@ System calls
>     ioctl/index
>     mseal
>     rseq
> +   syscall
>  
>  Security-related interfaces
>  ===========================

It would be more appropriate to name this file mqueue.rst or maybe ipc.rst.
This section of index.rst already has a heading of "System calls", so just
use a name that tells what system call it is.

> diff --git a/Documentation/userspace-api/syscall.rst b/Documentation/userspace-api/syscall.rst
> new file mode 100644
> index 000000000000..236c4cb88544
> --- /dev/null
> +++ b/Documentation/userspace-api/syscall.rst
> @@ -0,0 +1,273 @@
> +mq_timedreceive2 system call
> +=============================
> +
...
> +8) Concurrent access: verify that simultaneous peek from multiple
> +   threads returns consistent results and does not corrupt queue
> +   state. Verify that a concurrent mq_receive() and mq_peek() do
> +   not race or oops.
> \ No newline at end of file

Add a newline, please.

-- 
~Randy

