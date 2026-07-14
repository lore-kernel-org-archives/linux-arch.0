Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183FE427FAD
	for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065559; cv=none; b=f3spDne7WtfVH6dnVeI5UxBvD9zETpHzTdvkXqwGBmMAYJj1D48hlbtE39MTJTxzOuA4sTXSyq2UlnyLLXG225mzBL0TuQprMUeOgWtgRDDyaKD3kf8DyW1ItgMVE5J9zClplTTFdDZwa4Y1iFHS+AVUdX3UOWSS9j9HOvQ7bdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065559; c=relaxed/simple;
	bh=cAVW45uqQg2SRPEYKmKtszJRvMO//7p4A7xPCiBzVyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnP6cQ271+YGv9XrJ+L69oWAfbfo0vS9a2ElcsEy84LSge37Lo/KLXvsCJp8YyXqd3vGowNj90gAuuEwn4QXVNk11lUhNl36HsF7a7KQPD5DbB83IlDfNo77oWErFNPpGD8UDTBkfxFCSDToPoElh/ubHuobqjSRYqCaDjYJMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkjWbcaa; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkjWbcaa"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493e8d4f4dcso36559575e9.0
        for <linux-arch@vger.kernel.org>; Tue, 14 Jul 2026 14:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784065556; x=1784670356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lsgDUhCPZi1cUpPkNQ/I7/JmqQLLDAJpIhlyKeHE0tE=;
        b=KkjWbcaazAke3wXuU80om0NUqMSXZObBDwLbhD/9EV5XAxe3Xq6GRLNsM8aoBv3HdJ
         dW6MdyWIupPBH2Pyr/S2bwdL+ClHqaQ+LVgx1JLKA3G7ASLVatx3lX6lE9fjL0rnJHk0
         mgr8pokiOu++KxonyRuT5nChTpiJjJJvrt+8/3YGXm2owcmxJq+uLW6Nb7l9ECyS/Orx
         st30PZQ9xPol8bl0v8EPr0EvpfEw9W1w9i/+AKCg+uiX6MGJUTK5ZR2y4OdhKvq767CH
         o1bGfs4S9DJxz9Enexow/bW+AjFBUIAXPf1g9uElm0dnJZz8kvTDpQjfcUuTr/+eMVO5
         mVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784065556; x=1784670356;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsgDUhCPZi1cUpPkNQ/I7/JmqQLLDAJpIhlyKeHE0tE=;
        b=T8YFAC9CKfRRGsLcPzJQcSEsUnL7sElh8BmdFpSLOchagGkQSwhlC1zItca3L9Il/i
         3Ixs9nvP41egFYR3Pv9NDM74dD2jnB1v0fPY0IyicL9djsMJ3aKmbhnmHPH468OxrRbg
         jlCXajDCQ1U9F/ZVDGrYoT/m7zypjLL36BmmfBKsKc370v3tcjZTQGWSpqWEc56vryL2
         Pgj0/Ty+88SwcbL4yGq69gKse1Jf+LSNWgRRbNEf5jgJfa21Q+5w1ceyDGl6rbltVC8K
         HF/dtIyxybPESdotY3ln3zR47qcLrwWfc1UhT11SN6hAjPOL/BQ3ely1Pz8LhJQ82AXL
         6GGg==
X-Forwarded-Encrypted: i=1; AHgh+Rpup005EiME2LGBqamr7hjuQpx2+0dv8duUto8pefYU54g4I0cQPaKKBOqGfue6tv6Dtda1Ph0Sn0Ob@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8aBTEx66BL28R9mzwMEJ+B1LpWb0CmX18i7zdd1KK5ySpZuDw
	qvQ94PKlgjRntRyiEqQLy6iPwPRQDoeFZzbd/0AYWa8wL04HFNv211ZR
X-Gm-Gg: AfdE7ckmD5VK1nBUIc7FcAvPnTzGPPvQXeqAZyHZuBTD2XDw1xfGJz4KFoAhJW5Q4vC
	XeiQoVJQ1P8FckQTILQHi//+mVAZp1w0Y/TNQYe2NgkiK3XobBNdkV96PkvcKnQIx/osB+pZQDw
	f7QKK8YMiFVSOG2tgtmNV5hHeHLYEtz3fBynW82kf2I0vUac9QNBgD9XRu5S+7hMHueVeAc+caX
	i/8H6gOAcgxnOnPXVapUD8Eod3Rp0TIVH7AwNrZAYgphtt4e5FNgSyHTX4Qr2h4KpqBNmZdr+9k
	8yN539sE09f/dKHHo5soNYNn+SdXuzRsBNXQUMpfg6tY05Ps34x/Bau6QylWjpkfRJmb7Adl2Jk
	wJnwaGB65ZUgy0jZhCCwEX7oWR8v18cn9wJBVZGmLdh0t2C+K9xJ1erhdxAWW3CkbyPesevue50
	JbqKLr0Sa5iu32nctbFbzCUHmmhdKzMAfyZM8pFUaxIqCVhKMz7A==
X-Received: by 2002:a05:600c:4e8f:b0:493:b307:6777 with SMTP id 5b1f17b1804b1-4953c273de7mr4061435e9.22.1784065556082;
        Tue, 14 Jul 2026 14:45:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a32b9f3sm118533945e9.13.2026.07.14.14.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:45:55 -0700 (PDT)
Date: Tue, 14 Jul 2026 22:45:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Pedro Falcato" <pfalcato@suse.de>, "Yeoreum Yun" <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, Linux-Arch
 <linux-arch@vger.kernel.org>, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, "linux-csky@vger.kernel.org"
 <linux-csky@vger.kernel.org>, linux-m68k@lists.linux-m68k.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, "David
 Hildenbrand (Red Hat)" <david@kernel.org>, "Russell King"
 <linux@armlinux.org.uk>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Ankur Arora" <ankur.a.arora@oracle.com>, "Mike Rapoport"
 <rppt@kernel.org>, "Magnus Lindholm" <linmag7@gmail.com>, "Christophe
 Leroy" <chleroy@kernel.org>, "Klara Modin" <klarasmodin@gmail.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, "WANG Xuerui" <kernel@xen0n.name>, "Kirill
 A. Shutemov" <kas@kernel.org>, zhangtianyang@loongson.cn, wangyuli@aosc.io,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Ryan Roberts"
 <ryan.roberts@arm.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Rohan McLure" <rmclure@linux.ibm.com>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Tejun Heo" <tj@kernel.org>, "Kevin
 Brodsky" <kevin.brodsky@arm.com>, "Anup Patel" <anup@brainfault.org>,
 atish.patra@linux.dev, "Paul Walmsley" <pjw@kernel.org>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, "Alexandre
 Ghiti" <alex@ghiti.fr>, "Dave Hansen" <dave.hansen@linux.intel.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "Michal Hocko" <mhocko@kernel.org>,
 qi.zheng@linux.dev, "Shakeel Butt" <shakeel.butt@linux.dev>, "Kairui Song"
 <kasong@tencent.com>, "Barry Song" <baohua@kernel.org>, "Axel Rasmussen"
 <axelrasmussen@google.com>, "Yuanchu Xie" <yuanchu@google.com>, "Wei Xu"
 <weixugc@google.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>,
 "Alexander Potapenko" <glider@google.com>, "Andrey Konovalov"
 <andreyknvl@gmail.com>, "Dmitry Vyukov" <dvyukov@google.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "Anshuman Khandual"
 <anshuman.khandual@arm.com>, "Yang Shi" <yang@os.amperecomputing.com>,
 chaitanyas.prakash@arm.com, "Ard Biesheuvel" <ardb@kernel.org>, guoren
 <guoren@kernel.org>, yang.li85200@gmail.com, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Dinh Nguyen" <dinguyen@kernel.org>,
 "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Vivian Wang" <wangruikang@iscas.ac.cn>, junhui.liu@pigmoral.tech, "Muchun
 Song" <muchun.song@linux.dev>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, "Nam Cao" <namcao@linutronix.de>, "Pavel Machek"
 <pavel@kernel.org>, djbw@kernel.org, yu-cheng.yu@intel.com, "Baolu Lu"
 <baolu.lu@linux.intel.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Coiby Xu" <coxu@redhat.com>, "Andreas
 Larsson" <andreas@gaisler.com>, "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Geert Uytterhoeven"
 <geert@linux-m68k.org>, "Stafford Horne" <shorne@gmail.com>, "Jonas Bonn"
 <jonas@southpole.se>, "Stefan Kristiansson"
 <stefan.kristiansson@saunalahti.fi>
Subject: Re: [RFC PATCH 02/34] ARM: mm: make 2-level pgd_t a scalar
Message-ID: <20260714224553.583c8445@pumpkin>
In-Reply-To: <aceb8582-bafa-41b3-8f56-77fec89a4d90@app.fastmail.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
	<20260713135614.1618183-3-yeoreum.yun@arm.com>
	<alYL7B0HAvmLVHGU@pedro-suse>
	<b7dbc476-1477-4004-93b3-c5e667e24df8@app.fastmail.com>
	<20260714143450.61a94085@pumpkin>
	<aceb8582-bafa-41b3-8f56-77fec89a4d90@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jul 2026 17:06:00 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Jul 14, 2026, at 15:34, David Laight wrote:
> > On Tue, 14 Jul 2026 13:55:18 +0200
> > "Arnd Bergmann" <arnd@arndb.de> wrote:  
> >> > I see the compiler has an awkward time returning a u64 struct (see
> >> > https://godbolt.org/z/qejbv6j9a), but if this doesn't work maybe we should
> >> > get rid of the STRICT_MM_TYPECHECKS stuff? I seriously doubt anyone is
> >> > purposefully toggling it on for testing from time to time.    
> >> 
> >> As far as I can tell, the #ifdef was originally in i386 and
> >> got copied to all other architectures at the time, but was
> >> removed in linux-2.3.23 from the original copy when CONFIG_X86_PAE
> >> was introduced.  
> >
> > For x86-32 the makefiles request 64bit structures be returned in registers
> > (at the same place regparm=3 is set - probably added at the same time
> > between 2.4 and 2.6).
> >
> > Note that arm32 can will return a 32bit struct in a register and
> > arm64 will return a 128bit struct in two registers.
> >
> > The only problem is returning a 64bit struct in 32bit mode.
> >
> > I'm sure this code is arm64 only.  
> 
> The file we are talking about is arch/arm/include/asm/pgtable-2level-types.h,
> which is definitely 32-bit only and force a 64-bit struct return
> on the stack.

I've clearly failed to detect the environment :-(
The 'struct return by reference' is part of the ABI.

> I checked some trivial tests that show that arm-linux-gnueabihf-gcc-16
> also still produces badly optimized object code with structures
> passed by value, and will spill those to the stack for no apparent
> reason. clang handles those just fine as a pair of registers.

I'd have thought it would be ok if the structure had two 32bit values
and they were directly accessed.
The silly test I did earlier didn't spill.
Taking the address could easily force a spill in the function itself.
So that ((int (*)[2])&var)[0] (which is just ((int *)&var)[0]) is likely
to be problematic - or certainly heading in that direction.

> For the 2-level page table, this only concerns pgd_t, which is
> rarely passed around or returned by value. The 3-level page
> table has a 64-bit pte_t, which means we probably won't
> want STRICT_MM_TYPECHECKS there.

I did do some mmu setup for a strongarm a long time ago.
I do remember in being odd.
But I was only moving the software frame buffer away from the physical
frame buffer to steal a load of screen rows for a keyboard.

Is the 64bit pte_t needed to get the extra modified and accessed
flags there aren't free bits for in the hardware pte?
Would it have been possible to use bits that are fixed in the hardware
pte for the extra bits and write the value to pte[0] and pte[256] fixing
up the value written to pte[0] (that the hardware reads).

The arm docs seem hard to read...
(the left-right scroll doesn't help!)

	David

> 
>       Arnd

