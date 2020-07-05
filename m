From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 3/5] selftests/powerpc: Update the stack expansion test
Date: Sun, 5 Jul 2020 19:52:44 +0200
Message-ID: <8f6c5175-32ce-34a2-873d-b5fb3a5d7c4c@csgroup.eu>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
 <20200703141327.1732550-3-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:62714 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgGERwx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Jul 2020 13:52:53 -0400
In-Reply-To: <20200703141327.1732550-3-mpe@ellerman.id.au>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: linux-arch@vger.kernel.org, hughd@google.com, linux-kernel@vger.kernel.org



Le 03/07/2020 à 16:13, Michael Ellerman a écrit :
> Update the stack expansion load/store test to take into account the
> new allowance of 4096 bytes below the stack pointer.

[I didn't receive patch 2, don't know why, hence commenting patch 2 here.]

Shouldn't patch 2 carry a fixes tag and be Cced to stable for 
application to previous kernel releases ?

Christophe

> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   .../selftests/powerpc/mm/stack_expansion_ldst.c        | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
> index 0587e11437f5..95c3f3de16a1 100644
> --- a/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
> +++ b/tools/testing/selftests/powerpc/mm/stack_expansion_ldst.c
> @@ -186,17 +186,17 @@ static void test_one_type(enum access_type type, unsigned long page_size, unsign
>   	// But if we go past the rlimit it should fail
>   	assert(test_one(DEFAULT_SIZE, rlim_cur + 1, type) != 0);
>   
> -	// Above 1MB powerpc only allows accesses within 2048 bytes of
> +	// Above 1MB powerpc only allows accesses within 4096 bytes of
>   	// r1 for accesses that aren't stdu
> -	assert(test_one(1 * _MB + page_size - 128, -2048, type) == 0);
> +	assert(test_one(1 * _MB + page_size - 128, -4096, type) == 0);
>   #ifdef __powerpc__
> -	assert(test_one(1 * _MB + page_size - 128, -2049, type) != 0);
> +	assert(test_one(1 * _MB + page_size - 128, -4097, type) != 0);
>   #else
> -	assert(test_one(1 * _MB + page_size - 128, -2049, type) == 0);
> +	assert(test_one(1 * _MB + page_size - 128, -4097, type) == 0);
>   #endif
>   
>   	// By consuming 2MB of stack we test the stdu case
> -	assert(test_one(2 * _MB + page_size - 128, -2048, type) == 0);
> +	assert(test_one(2 * _MB + page_size - 128, -4096, type) == 0);
>   }
>   
>   static int test(void)
> 
