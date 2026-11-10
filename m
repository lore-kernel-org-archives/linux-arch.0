Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323301;
	b=08ip2UKOlV49S04VmAR/s9fQUxinfeh2cxDW/LO5BDWXs4K9wKBrNzblK2uhTD92u/P6
	 G7srMbbPHj+bGniOkQ2JsNYsgBv+8OD91rQKvXkve5XRnCErOjbI03XVairlvhuw1BLkU
	 fpjbzM50M5/8DB24Ll2qGhI7PLU17X8s12++3L4SnPggw9iErQGSfyadB8HAFgnZyzgLM
	 HrVFV5JPpg6EDA7LKPOI2LczFs0I00Xp6URT7rAtpAshtgYyIimGX8CRA2aysfAF7W+1T
	 Dkrz+xezjKUSBvfe8KOPyS1dOgqqtBPTglPgfHhtwA94N7L+PSvtl+qNay9SDjJ/cRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
	b=tJouzikpRWCUjQHHGRwnzAEk0zvZdg4R3/hdw/XQZ6vkKxMffdyCY2XQBTIizcXK7O5T
	 1YzY4rK5wqyJzUQ4TZlM+rV4hXYvu8IlUkMY4Vq8nfouJtfpoIRKQYgk/7W+Dm1Yrz8oZ
	 fxy9kGu/2kO/b5ajI/ZtiMa5nfrZkkoWmi52EsoUV1qHlSCehZ3ePLzPeG70AXn6dbVrK
	 ZLQJ/r0S+uwcSoAmUA9oN7349sjiSf3hSdsk4DaS4c+/R7+CmvcFNvsXAWpWVZ2Z4EuSc
	 YTrsa4dlt8ZloRS5YrKpn8GraISOqeAoDvwYO70JiPEBiHdNdsMt+bhpHZE4EbfsE4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="MY7/VxB1";
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5B606A336
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 15:08:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BA5B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=MY7/VxB1
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9908c849564so582040241.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323300; x=1794928100; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=MY7/VxB1O/0DDBob4OhFBhE2r7AqoArsc4vheQsUZdhXDD+b5y1y1TaQrVm/bdwM31
         v+wvR1Xa3Ogoqeh918QB8QJkmxoGqB/R4NBJ2DOJcela0Ni/GKwIGZk8KpF3tas6I5PQ
         qKvtJzIG9/afJgpmJCT8Wdk0JCrpgGt8FzAo9UC1qJ+1YInuolQ9XLeruvGJazzi6dQA
         6/dnbpjLZxKCsl3iAfGw/gz7uTLTFH0Bl0FPaSew7qw4Mq3brXG6aw9DcGgQGyAglMNu
         RxiC7KvyFW8YJvykaeY5KOEMdF2MdmBGATrfsR7KNl7p0+qOdzVYWZayVDtF6hymuNJo
         lB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323300; x=1794928100;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKAEhFQ+Dah3DMHVjGDEQ1FI4504gN8wbhTTvAQenls=;
        b=kARbA2LdD2y7znuFK6GJFHdVf13viOePP5Kosh/P4UlSg8LoYiiCdH6Kdu1SyGmtaB
         TTPAlCQ6ZBONUhCCNO5s5P+NcI1q8ye10UnKLe9srMf6Dn2wlnk3KsdoCyEXktE3Ulh0
         IEccshN8ma2FX3PeM18K3nP+tfo1q24eN5pHIkFQ/2SDiW3pf1OqTcHp9tFaalW8DPNI
         YrNSegWr2LZ8o+yPZmnMUdexOAdseWvNsgF2ciERvQ6hYLEnneOuwckIpBvZNxoS53cx
         wRn535zJBg6v9/EOZtFSFYzO+RBzvCXhfIl0TATGBKV/hOSyuLSmodpEj55Euyl1bKJB
         cVuA==
X-Forwarded-Encrypted: i=1; AL+hErHf2DdlGU/b3xIf8xNDmhOShC6iLZsNMDaPywFHsorOCbOUf+j/7tGlIz/Hmbiazm87f4vGsmAA9iEn@vger.kernel.org
X-Gm-Message-State: APuU4Z8hOIwrtJxpcsPtAn4eT3wnn55wuX6ilHck7kROFpM+SaeB7H4w
	F14cUydEc6oT8aEXXEreBkuUloVa164M4C/cUxdT0NyqBuk1FEDGjGiWJHO4OU//fF4=
X-Gm-Gg: AYBFou0xAj9nU5eya5LRF3QH1QDFtnTEnY0quUOzge1BTe6tIU9HJMqbFZZQOGjdV+b
	5oNUT850iKL0dtW+TCso4Y7R1pO6/eu4OFHzXFcgllpWymP5t8O91zYpvd1Z0FebhmmHoU9wWSG
	kgKcG9n5ykzTfY508C2J277nD4KoGI3JSq1QynX0CrgqdOwiCTcwH1s2irpskO7Q2Gt5je6vJFF
	0/ulBRQcsquIKNc6tuHK7jKvqKEJYX33yhh7JH/QHD7zimOuf0Zk2VhGjqRVVZ7J2w7G+Ixs2Lv
	zW78XstS9/xqHXSPLq0U2FZAguMI89aLZiVFYCBt8UI8irHdK0bXo7dY4BQkJLditi89VmnpX8p
	WdOsZQk3odgAGLlH3sIBX1CvtTAdlDTBbWYBq15zitudA0CAukMvLEubOtbG/XG+HgJiZCTXT85
	Aamuo5ZUrezoXuNCQMDfQyJE3myPtwOpZCG3ojPyORNMMEIQ6FG5/Si8kBYGeBzRwmrwHSWcANE
	VU1xLDbXsIhWqpFibOF09axWLkskYd9bFsqM3PFTeMGxwVUFascD8CLYDiNmbH9B2qKrcR02Mnf
	ayseoVqVHGXbkB1EsoKpa423vi7w5J2GvOXElYKZUNlhjP2QX/jhw7JiszxnPPxP1KWS0nNJbLo
	+Sjm5NI0xgrT9Bja3JL8W/SX3iQLkb5zbNerxS7kFv63d
X-Received: by 2002:a05:6122:468c:b0:5da:a74:d6a4 with SMTP id 71dfb90a1353d-5ee0d1254cdmr983516e0c.15.1794323299946;
        Tue, 10 Nov 2026 07:08:19 -0800 (PST)
Received: from soleen.c.googlers.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c1fffe63asm1965122241.4.2026.11.10.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:08:18 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-7-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-7-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 10:08:12 -0500
Message-Id: <179432329215.2329176.14453669404153142360.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3169;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=QPKh6oqVuep5a0uq5kk2HJ+pkn4UzCARnNzVJdUZk/E=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8zNhLa8G7KPQhtpqNqIaC7iUSrItiw95IH4+W
 4FZp+mLRNmJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMzYQAKCRC7dyhM23N6
 3ixyD/9hSlVPu6pn+Usl6EKxRh1wkp2nNTAGfSwd0T80brdKlRNG7a8mQqhUQi1H7cXmovyHBUq
 ES73eQCtV9EEqD3V+9mhbM/vQ3DNxapFoBftgUpOKocv/TyzS+fnYCCd+V4qkZp6JbEE04DX5ph
 RXIIzYY1cOoM3lIFUa3WAKuQ5IlLTqUrcCnmCGDDA2ABc3Dn4YGxVfA+j1TEgs3i5/pZ3Jg6vPm
 2w2Rki59ZZh1OvjNwqaQcNxFUaUzOua2A1T1C5uWqXUw29+H364g+FPC9TsTFighlf5Dm5nInFm
 sy05T7yV7PmS1d4eRFn5VjWQo2hboOwrVmB5E3sLTnbZ+oXkY0TgWbPqKYlXfKYQ1RF1dttkf3y
 L666oJVxxNOxQuWbB80WyaaQp1G11CUhLjsRBaxuJqYWD3LuhT6NKGc7rkKJ+4Y1QHbv77qrsL0
 xU62OLvV+UYlxbDgjPM1r4q1njY/2zmio3uMBSt4oubrAmtiUMAW6J6dY86mFHlcm8xgbSUbn5B
 HOb83UbLMhoMCV4Zf4R9ofmr8Zb5PO+Ieg4+UAv33DElEYGHzsZJuh7rv0KDrtHn6JA4zqY3vNY
 KpfJSWU9gzyoa94bAOMSWiRRC/83AeXcMfiQw7G8I+bNVH6Sm/Q6RfvqXkiiTkw9BXIWwqNbXQH
 2NBA/068NaYZqOw==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

> The kexec metadata subtree currently uses a monolithic u32 version field
> to identify the metadata structure layout. Any change to the structure,
> even an optional additive field, requires incrementing the version and
> breaks compatibility between adjacent kernels.
> 
> Replace the u32 version field in struct kho_kexec_metadata with
> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
> under new feature indices without breaking compatibility across kexec.
> Also make the 3-byte padding hole between previous_release and kexec_count
> explicit as reserved[3].
> 
> During deserialization, validate the blob size against the header size
> and reject unknown required features. A legacy v1 metadata blob is
> ignored with a warning.
> 
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
>
> diff --git a/include/linux/kho/abi/kexec_metadata.h b/include/linux/kho/abi/kexec_metadata.h
> index e9e3f7e38a7c..316b3e5ad01b 100644
> --- a/include/linux/kho/abi/kexec_metadata.h
> +++ b/include/linux/kho/abi/kexec_metadata.h
> @@ -18,28 +18,31 @@
>  #ifndef _LINUX_KHO_ABI_KEXEC_METADATA_H
>  #define _LINUX_KHO_ABI_KEXEC_METADATA_H
>  
> +#include <linux/build_bug.h>
> +#include <linux/kho/abi/feature.h>
>  #include <linux/types.h>
>  #include <linux/utsname.h>
>  
> -#define KHO_KEXEC_METADATA_VERSION 1
> -
>  /**
>   * struct kho_kexec_metadata - Kexec metadata passed between kernels
> - * @version: ABI version of this struct (must be first field)
>   * @previous_release: Kernel version string that initiated the kexec
> + * @reserved: Reserved for structure alignment; must be zero
>   * @kexec_count: Number of kexec boots since last cold boot
>   *
> - * This structure is preserved across kexec and allows the new kernel to
> + * This structure is preserved across kexec and allows the target kernel to
>   * identify which kernel it was booted from and how many kexec reboots
> - * have occurred.
> + * have occurred. Preceded by &struct kho_ser_hdr.
>   *
>   * __NEW_UTS_LEN is part of uABI, so it safe to use it in here.
>   */
>  struct kho_kexec_metadata {
> -	u32 version;
>  	char previous_release[__NEW_UTS_LEN + 1];
> +	u8 reserved[3];
>  	u32 kexec_count;
> -} __packed;
> +} __aligned(8);

Why __packed was not removed in the first commit? __aligned(8) should 
not be needed, given that it must follow DECLARE_KHO_SER which is 8-byte 
aligned.

> +
> +/* Register kho_kexec_metadata with KHO serialization accessors */
here and in all other places, please remove this comment.

> +DECLARE_KHO_SER(kho_kexec_metadata, 72, 0, 0);
>  
>  #define KHO_METADATA_NODE_NAME "kexec-metadata"
>  
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe3181..2edd772bb6d3 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1740,6 +1740,7 @@ static __init int kho_out_fdt_setup(void)
>  
>  static void __init kho_in_kexec_metadata(void)
>  {
> +	DECLARE_KHO_SER_HDR(kho_kexec_metadata, *fhdr);

Please don't do this, use kho_ser_hdr directly.

-- 
Pasha

