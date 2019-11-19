From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] exec: warn if process starts with executable stack
Date: Tue, 19 Nov 2019 08:32:30 +0300
Message-ID: <20191119053230.GC5626@kadam>
References: <20191118145114.GA9228@avx2>
 <20191118125457.778e44dfd4740d24795484c7@linux-foundation.org>
 <20191118215227.GA24536@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191118215227.GA24536@avx2>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org, ben.dooks@codethink.co.uk
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 19, 2019 at 12:52:27AM +0300, Alexey Dobriyan wrote:
> There were few episodes of silent downgrade to an executable stack:
> 
> 1) linking innocent looking assembly file
> 
> 	$ cat f.S
> 	.intel_syntax noprefix
> 	.text
> 	.globl f
> 	f:
> 	        ret
> 
> 	$ cat main.c
> 	void f(void);
> 	int main(void)
> 	{
> 	        f();
> 	        return 0;
> 	}
> 
> 	$ gcc main.c f.S
> 	$ readelf -l ./a.out
> 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>                          0x0000000000000000 0x0000000000000000  RWE    0x10
> 
> 2) converting C99 nested function into a closure
> https://nullprogram.com/blog/2019/11/15/
> 
> 	void intsort2(int *base, size_t nmemb, _Bool invert)
> 	{
> 	    int cmp(const void *a, const void *b)
> 	    {
> 	        int r = *(int *)a - *(int *)b;
> 	        return invert ? -r : r;
> 	    }
> 	    qsort(base, nmemb, sizeof(*base), cmp);
> 	}
> 
> will silently require stack trampolines while non-closure version will not.
> 
> While without a double this behaviour is documented somewhere, add a warning
                  ^^^^^^
doubt

> so that developers and users can at least notice. After so many years of x86_64
> having proper executable stack support it should not cause too much problems.
> 
> If the system is old or CPU is old, then there will be an early warning
> against init and/or support personnel will write that "uh-oh, our Enterprise
> Software absolutely requires executable stack" and close tickets and customers
> will nod heads and life moves on.
> 

regards,
dan carpenter
