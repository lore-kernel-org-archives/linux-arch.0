From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Date: Sun, 29 Jul 2018 01:42:17 +0200
Message-ID: <b24739e8-0833-8509-0850-815758accaee@redhat.com>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532352037-7151-17-git-send-email-puwen@hygon.cn>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, JBeulich@suse.com, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

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
