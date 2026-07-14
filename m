Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6B246AEF2
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032471; cv=none; b=AfNlvpBzlUEMYubblLY9BBCDfZ/wh5Mw5OSJf9FO3OTNTMeLlVkbjiiXyqKccfJhMPmmHDjBRYofw154pRWJU8RIki6eBD+QQyWk7Kh4ObdFFU69k4VHZbP0EjC1o50HEFOMXZGNadKqoProce1SPsJlI0FulKbCfm63SVRllAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032471; c=relaxed/simple;
	bh=WegHpjcb2vagWqLjN3VnSMlDf7mDmA8mmd3Rp43fqxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXvZUVNRK0Fh2ZYYu5z6z11IDUT3nqoC0HaJiHBCE5hhq7YNXdOtwQ7CH9OLpNF6FIvXH5Ycm1NmVcfmZzDgnUNp0aTBuKNDJcqv1BKnLIAAPMldIhZ2uDnGWyT6ITpcr2NF4I8eOXDy+h0kMJ8ISvRFQwrFcFu4464wZNOKPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYjlWK1u; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYjlWK1u"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f365afc5aso1350559f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 05:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784032459; x=1784637259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CcC3mXhC9vFPxE1TVGprdVmvuMWQZA/m1vfAGdGaT0s=;
        b=lYjlWK1u9qTN9m59IOgLZFFl6A3QUAJm3hdoEWMcd5UKeeBoShkzCviu2smy4APX3v
         NN5AZkPK1ppnlJXxGIYtb3uSBTUAc0B+wayHesZpCBe4jytJPUY+BljPijmMgpcegPIF
         PXKSWEOW3ErIiWzcHUW6W3XWuMiWkNtznHfjgl+Ze5WjS7p75CkTtBEUjZ7eYYEb4WVe
         t/wLiAqhA+bcnEt3jwXlx9rr7iFDZTXx8m0oTcDew40YJPRuD5W9kS9Gacv+xSLvl4Q5
         oTVGJsu9IQsI31fiS/t7+SgCqd9JTLWr2IMEoMEi7hVerkpv7kPlwAdXOuOq2N56iugM
         Hrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784032459; x=1784637259;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcC3mXhC9vFPxE1TVGprdVmvuMWQZA/m1vfAGdGaT0s=;
        b=IN/f+/mtT4aPLFquDXqCf5a2SGKgWc4Ck3tXpDxT/VAXzx4+c2tp9ID6zmNT3qxBgl
         +d+BgirtdR8Nqumcc4CxNtY28Ko5YafMciPyfPRRwrdQden4H7ReQDntVyghqz6YwGwT
         5iAi4/SO2eyOX2mXCW23OTNwke9OLbt89XOvKUL3YR3VvUhQM06ofm3jtMZXNXXGeEg+
         gxKi6Wuan++XInIpvBU3xqaRrhVTnFmfTpw5DYaBsOLz7B2iPmrNuHTkBEczx68ofKDe
         ZbN+CMq3BJmvFEAFh0LLRMNQHAU0jdthIDQKinjD+EBBsAzxtj9vUczSddcKN0KW+NBx
         k9gw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1wZTTQSK+smo4zibG1nnZo09fPa3uZ4FqCCPMVfUnDzBgbFCueoSMSTSlV6nW15pq1ZhMp+QiLWjS@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxBoa+F4NlYqENqH8NnDSlcoHBuBokg+IV+S2GqthYybAow3k
	VIZ/wx0r54JqLSDlXo6HT62EQPyVaHQ3sYHebKKO2TNn8DVlIuAH7wQ4
X-Gm-Gg: AfdE7cmoESF5ZphGXCYQhcG4VtPXj7tfsaobMugS3GYEVR3mNTz564tpXKNH8Tfb5eS
	xSkvqEdftgQworFvx3MRvIkIZuA0ZWy1U4mBlaPnJ1R8T52YM1xu+xwuvxpdpqmNPuf02U8rSLH
	d0qSg45dlgodvg4Vi8jVKLF86BkkP5Ho5AHOlObXaW/TdtjaKrZyO/2X6o4TAipWQSPm8wBNhi2
	GSnF/hoZfEzOa7PN+7orHsG7h/qpR+IuUlVLB4hbyQC6IRWMFcLcSSVowS93lWxAcooifYJuGg6
	ORAU/zPG6MFXMptSPpVPU3jQgBPRIMHitZ1fMpuhDxh78ysJRmTvR9tuZ71cQJ05khFDlfvT6pb
	Dk7YvDyGy9QWRVg0dztm86Yh/o8UYAyQvpz9+jDjcExF68+iNWZ1m/ahlRsg667Ke3tG2XlareJ
	MqUu094v5h08cRb0lELo5t+ojITzQXTFY7Ybl6EqGW9rUqz6obuRRbRfm9unRG
X-Received: by 2002:a05:6000:4903:b0:47e:9d58:3b4e with SMTP id ffacd0b85a97d-47f4887f947mr2511343f8f.24.1784032458400;
        Tue, 14 Jul 2026 05:34:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c1f84sm8103524f8f.29.2026.07.14.05.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 05:34:18 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:34:15 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-arch@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, linux-csky@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 david@kernel.org, linux@armlinux.org.uk, akpm@linux-foundation.org,
 ankur.a.arora@oracle.com, rppt@kernel.org, linmag7@gmail.com,
 chleroy@kernel.org, klarasmodin@gmail.com, chenhuacai@kernel.org,
 kernel@xen0n.name, kas@kernel.org, zhangtianyang@loongson.cn,
 wangyuli@aosc.io, tsbogend@alpha.franken.de, ljs@kernel.org, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 ryan.roberts@arm.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 baolin.wang@linux.alibaba.com, tj@kernel.org, kevin.brodsky@arm.com,
 anup@brainfault.org, atish.patra@linux.dev, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 hannes@cmpxchg.org, mhocko@kernel.org, qi.zheng@linux.dev,
 shakeel.butt@linux.dev, kasong@tencent.com, baohua@kernel.org,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
 dvyukov@google.com, vincenzo.frascino@arm.com, anshuman.khandual@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com, ardb@kernel.org,
 guoren@kernel.org, yang.li85200@gmail.com, viro@zeniv.linux.org.uk,
 dinguyen@kernel.org, schuster.simon@siemens-energy.com,
 wangruikang@iscas.ac.cn, junhui.liu@pigmoral.tech, muchun.song@linux.dev,
 vishal.moola@gmail.com, namcao@linutronix.de, pavel@kernel.org,
 djbw@kernel.org, yu-cheng.yu@intel.com, baolu.lu@linux.intel.com,
 Jonathan.Cameron@huawei.com, coxu@redhat.com, andreas@gaisler.com,
 liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 geert@linux-m68k.org, shorne@gmail.com, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi
Subject: Re: [RFC PATCH 02/34] ARM: mm: make 2-level pgd_t a scalar
Message-ID: <20260714133415.78e25654@pumpkin>
In-Reply-To: <20260713135614.1618183-3-yeoreum.yun@arm.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
	<20260713135614.1618183-3-yeoreum.yun@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 14:55:41 +0100
Yeoreum Yun <yeoreum.yun@arm.com> wrote:

> From: "David Hildenbrand (Arm)" <david@kernel.org>
> 
> We don't want pgd_t to be an array, as it prohibits returning it from a
> function, like pgdp_get().

If you use a two element structure the compiler/ABI might be able to
return that from a function in two registers.
That might make the entire mess more readable ...

	David
