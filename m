From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Mon, 19 Sep 2016 10:35:37 +0530
Message-ID: <87vaxsxyvy.fsf@linux.vnet.ibm.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbcISFFp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Sep 2016 01:05:45 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u8J52on9103359
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2016 01:05:44 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 25gxqhvbbc-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Mon, 19 Sep 2016 01:05:44 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
        Mon, 19 Sep 2016 01:05:43 -0400
In-Reply-To: <20160916085736.7857-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>


> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index 3b5bafc..695743c 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -25,9 +25,8 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
>  		preempt_enable();
> -		do {
> -			cpu_relax();
> -		} while (test_bit(bitnum, addr));
> +		spin_do {
> +		} spin_while (test_bit(bitnum, addr));
>  		preempt_disable();
>  	}
>  #endif

That usage is strange, with nothing in the do{ }while loop. May be add a
macro for usages like this ?

-aneesh
