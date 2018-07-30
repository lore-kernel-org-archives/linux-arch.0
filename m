From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v2 16/17] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Date: Tue, 31 Jul 2018 00:43:18 +0800
Message-ID: <c8f53708-bd57-fb41-8300-115ac5083094@hygon.cn>
References: <1532352037-7151-1-git-send-email-puwen@hygon.cn>
 <1532352037-7151-17-git-send-email-puwen@hygon.cn>
 <b24739e8-0833-8509-0850-815758accaee@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b24739e8-0833-8509-0850-815758accaee@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de, bp@alien8.de, thomas.lendacky@amd.com, mingo@redhat.com, hpa@zytor.com, peterz@infradead.org, tony.luck@intel.com, rkrcmar@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, rjw@rjwysocki.net, lenb@kernel.org, viresh.kumar@linaro.org, mchehab@kernel.org, trenn@suse.com, shuah@kernel.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2018-07-29 07:42, Paolo Bonzini wrote:
>On 23/07/2018 15:20, Pu Wen wrote:
>>  scrubval = scrubrates[i].scrubval;
>>
>> -	if (pvt->fam == 0x17) {
>> +	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
>>  __f17h_set_scrubval(pvt, scrubval);
>>  } else if (pvt->fam == 0x15 && pvt->model == 0x60) {
>>  f15h_select_dct(pvt, 0);
>
>This, and many other occurrences in this file, should in my opinion
>avoid testing family 18h without also checking for Hygon as a vendor.
>You probably need to add a vendor field to struct amd64_pvt and
>initialize it in per_family_init.

Thanks for the suggestion.

As AMD and Hygon will negotiate the usage of CPU family number
to make sure the unique of family numbers in both company's processors.
As Hygon will use family 18h for Dhyana, AMD will not use family 18h
and jump to family 19h for new product. So if family number if 18h,
processor should be Hygon Dhyana. Based on this assumption, we created
this patch set.

To keep consistency, surely can modify the patchset as suggested, but
will introduce some additional vendor checking codes.

If the vendor field is added to amd64_pvt, and check the vendor in 0x18
codes, then the codes may like:
-	if (pvt->fam == 0x17) {
+	if (pvt->fam == 0x17 || pvt->vendor == X86_VENDOR_HYGON) {

switch cases will be modified similar to:
+	case 0x18:
+		if(pvt->vendor == X86_VENDOR_HYGON) {
+			fam_type	= &family_types[HYGON_F18_CPUS];
+			pvt->ops	= &family_types[HYGON_F18_CPUS].ops;
+			break;
+		}
+

and:
	case 0x17:
+	case 0x18:
+		/* Family 18h is only for Hygon now */
+		if(pvt->fam == 0x18 && pvt->vendor == X86_VENDOR_AMD)
+			break;
+
		Do something here both for AMD 17h and Hygon 18h...

Any suggestions for that?

Thanks,
Pu Wen
