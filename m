Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6DE39CD17
	for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2026 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297669; cv=none; b=hsiqLvFlogITIN9shqyCkJw4LWo+pHcPyVLVkFPb8F9WVHF0WbbMnvWKtCMI3zXUsY4e+qzasFxB6oo+N9k9MXa7L3QBjfFMUVoKLgB4UTasy7UCFlAw5nlxqz/FDXjc9xcIqTkkBUdB3xrpYaHygnx+oJqGTxP9XeSC6fH7SgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297669; c=relaxed/simple;
	bh=/mYai3BRAUDtUio0FeZCqaBs35nCba5d4UWYCst/DXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dS5nrxgqghQOEM+QJGrwDyckjZjoriltd7jgxyGcyy4FwHIlskFpX7fpaPjnQoktUdu1/DZ8BJSKOBicYCX7us9HK4trlkyA8cif2x7PuNRDUBdmiVBDpTvtqxIOHIS31w2urvVYfjbi2EovRrwWNX4MSzRY+9Wrx3gwvB621Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eyo4+qk7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdIgSVMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eyo4+qk7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdIgSVMp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787297649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iZliJAMCxrV8BQaJTNvGaLRgIXasVWojRYBcZ1Jzkfg=;
	b=Eyo4+qk7vlidTPgZUFWV4XC9i9gm7TxaQNCxWBt6fj1SPCRrPlJ8DS7QPp+jxLQa9evLGc
	5wb4nlTGIsqPYkX7oqF0KI2OzpLwLzcTVm6SbAcucDRzh5RtoikReLTjUeyDrxd/x1suTg
	vCzrgywR/IWpTUSz5oRpHW12+a9Nh8o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-j2YP2DwAMx-JUpyQlMvo6g-1; Fri, 21 Aug 2026 03:34:07 -0400
X-MC-Unique: j2YP2DwAMx-JUpyQlMvo6g-1
X-Mimecast-MFC-AGG-ID: j2YP2DwAMx-JUpyQlMvo6g_1787297646
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2192261d79so73572766b.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2026 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787297646; x=1787902446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iZliJAMCxrV8BQaJTNvGaLRgIXasVWojRYBcZ1Jzkfg=;
        b=cdIgSVMpHtgr6wnNjDJrjocdqQGB/uPGvGrXMJztgEx8Op80zJ1krNbu8iPGX2Kmhn
         Q6zhqIW5Jy++AIfU9l61eRBJPV/sjGEzgr24gWQhcpOJWFBSqyNgi7O9fnPJKxH+RNVY
         HqtwZMIQdzpowr3DbRvdJhmL7RAHk3ptGOu80p5ddjS/r6wl0EGKLMC3hfKJJvUzL77P
         sS4A1FDQU8MLc5uGvVEwLU3eufuhndxYS0oOkmlqaF32JvS2cdsVcpuctIm0dSLmzzGn
         8JSXmsCx1JQtDVqmedypFQJLMyEHEgODzrOLUDOSFvN246wVmL2kcbXFElrNjbG8sfzH
         tvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787297646; x=1787902446;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iZliJAMCxrV8BQaJTNvGaLRgIXasVWojRYBcZ1Jzkfg=;
        b=eAowj+Wj7kTM/HKWmWly8SLM+HnbKjoYyYrU0hNCmuCt0+Gg8WSxVNcsUAZxO8XsGt
         Yzrvz412mmVXV2Q/AnVDfcAa8zjM35wndhY9Wr501vNXoGVKeF39amMQu0b6jp6nbPT9
         aH28PCLESkPUudkAaS8bCa8L3T8yq2XOY2sWa79PMd/VtXVkaNKQ3reumqksfzxds2D8
         GfxDAk6k9sDV4m1oMbSLbRKzKejUcRVBV9n1NWkZmgeR6Ew1dZjBeRPDMYyWuC+Z/NWP
         PIXoZfjKyb8REV2rbw8SX7AvbhP63r2gYXgJMctuJb+oCt1wpd0z2SVA3dX39IcWpv+2
         JYnA==
X-Gm-Message-State: AFuF++nP07cQ7k4sCCfWE9MBYTEjvRqcNVuIXMxbmihezBWsMAPJbT8D
	y0MbxtHGRYtj0Szn2Ax/nr5tT+fzuCA5CnEj4nLPm467fBstvBVCirAurneteGRzH6XWVVQxpFm
	qbwQRx37E4mmqsMjn6Ie6O+soiBKEqQdBEtFq+IX0/2Y3PBNzd+8CqBke7e3AUBU=
X-Gm-Gg: AR+sD12KXUJ/jHXiDdwHpqsOM4fU99uH5YX9jM9lelCfWME1IfVl1u7j2nkSXrOtrN4
	ufDcIsQWeDP7JW3onyqrBXQoCY8Szwa3nUEADTFqkhevtU/OJlPI2hj+YEmSWXyqSSxmClbDaWg
	ixXMNP971ryNOVltRdcQgI2nNdPUFgAsssNIkebl0AP9XXvJyWA6RGbGcxcvKgd7GURlRf1TVET
	o+66vx6cY2tyST541VUqSeWfFvX1EDZzLgUQkpRwsyKYBQYiX+l9xCUkFZY1vfCf86nbeh+wkah
	+Sjd9mSav5+mmchT541iPfeUW40ApdKZOIBE19czkTN0cPkJ9+IR5fIt837zIcuZG40BVe5r
X-Received: by 2002:a17:907:1c18:b0:c20:88a6:8210 with SMTP id a640c23a62f3a-c246a4f0b8cmr439962766b.9.1787297646283;
        Fri, 21 Aug 2026 00:34:06 -0700 (PDT)
X-Received: by 2002:a17:907:1c18:b0:c20:88a6:8210 with SMTP id a640c23a62f3a-c246a4f0b8cmr439959666b.9.1787297645962;
        Fri, 21 Aug 2026 00:34:05 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0d5f70sm5208136a12.13.2026.08.21.00.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 00:34:04 -0700 (PDT)
Message-ID: <695b505b-75bc-4aba-a161-c1061f219a2a@redhat.com>
Date: Fri, 21 Aug 2026 09:34:03 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>
References: <20260409094708.1687376-1-thuth@redhat.com>
 <20260409094708.1687376-2-thuth@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20260409094708.1687376-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2026 11.47, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/arm/include/uapi/asm/ptrace.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/uapi/asm/ptrace.h b/arch/arm/include/uapi/asm/ptrace.h
> index 2ef917957005c..15e6bff56b609 100644
> --- a/arch/arm/include/uapi/asm/ptrace.h
> +++ b/arch/arm/include/uapi/asm/ptrace.h
> @@ -110,7 +110,7 @@
>   #define PT_DATA_ADDR		0x10004
>   #define PT_TEXT_END_ADDR	0x10008
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   /*
>    * This struct defines the way the registers are stored on the
> @@ -149,6 +149,6 @@ struct pt_regs {
>   #define ARM_VFPREGS_SIZE ( 32 * 8 /*fpregs*/ + 4 /*fpscr*/ )
>   
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   
>   #endif /* _UAPI__ASM_ARM_PTRACE_H */

Ping!

Oleg, could you maybe take this patch through your ptrace tree?

  Thanks,
   Thomas

