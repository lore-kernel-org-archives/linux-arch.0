Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731480AbeG2BKl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Jul 2018 21:10:41 -0400
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b24739e8-0833-8509-0850-815758accaee@redhat.com>
Date: Sun, 29 Jul 2018 01:42:17 +0200
MIME-Version: 1.0
In-Reply-To: <1532352037-7151-17-git-send-email-puwen@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180728234217.7gvPpkQNBxxQQeUzsAs0n1cPr0bHZbUYpiM7mFDH5Q4@z>

On 23/07/2018 15:20, Pu Wen wrote:
> @@ -211,7 +211,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
>  
>  	scrubval = scrubrates[i].scrubval;
>  
> -	if (pvt->fam == 0x17) {
> +	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
>  		__f17h_set_scrubval(pvt, scrubval);
>  	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
>  		f15h_select_dct(pvt, 0);

This, and many other occurrences in this file, should in my opinion
avoid testing family 18h without also checking for Hygon as a vendor.
You probably need to add a vendor field to struct amd64_pvt and
initialize it in per_family_init.

Paolo
