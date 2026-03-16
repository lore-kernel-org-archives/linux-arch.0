Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB2536AB56
	for <linux-arch@vger.kernel.org>; Mon, 16 Mar 2026 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699176; cv=pass; b=jmunm01DQrEuxkUM+Gd77Tju0SpZCoiHGntxVQ23LuM95v9EZIKQOK0HbePEXnft87VT4DIlRUlVNt64mTLn73iq0C1alxsVxBHwCvdNmq7B58UKPtjY9zmen0yfIupgD1QicbaXzr87ZEiyGXOmHgWXafjK9jYveJ5tseCKP3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699176; c=relaxed/simple;
	bh=rsp7Ihi8TSAj7hc2vakkxGqqL2oEkNH6XMA5zjqI1qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4FKCw5VhEMHa6PUIOIJjNJwqlLxez80XceKfXDTAaEGp+8qSiE3Bth6c42JGAobfcjnCpSO50tqi/3yZ92pqW+tLjtVM5ucI+7pRuzQgKW3ENIFVi7XHhsoX9tEBclCnJJx0olZt9iV7SCrV/4Z8yOWAMN9OhMxTwZGeWOlGUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXFirVf+; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXFirVf+"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b97905516faso336716466b.1
        for <linux-arch@vger.kernel.org>; Mon, 16 Mar 2026 15:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773699172; cv=none;
        d=google.com; s=arc-20240605;
        b=MORCVXUSEcnlilqrvuUbCYANWQY+rG51IKlFxelNTmH5HPW2DgFpxiVe7lAIJOg8sP
         hX2B7U0l8oDqaGiUgMEJkX0JM97Tn0E9emALb/3OTTBQRmKWBurQCVEg4Hko0gIppfxs
         CDdBrwOMQxhpR/JkoEQB3zclgVSiXtrnwN1Kn6sWtdDXsZqdMChXtOfS5QPG1kLQymHO
         Zqspy+E5zDpREoSa2xwLiUHNPmO1pbQkfVN+xStlOSkXRT53YHKgxAEPwKrYRvoNCqQK
         2HlFINNucTrG3Pti+PMSknOZzi8cAvZ82jHp2iaP9RcwEUP16i+ofcX22HWUVlB4bICc
         +VTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        fh=RZw1dYPAzZo0MfVW+ek/NXMpxPG/3m+87MSHwc+JyGw=;
        b=WQVg10pEZSHg4EcLkQUnwhhwjzHW5rdnJ0HSH9AudpCSxeRJDaoHNaXFcx7YlgtB4s
         sI0MDhiwV2vhgKa9ONkfRhqdcRPFDuN05GENyei5gfhmC3q9tkMgev9dO/GKzfFlxjXT
         5WHv5GqiF4/1mXZfE/ed5x1SgYrkpJaiMr5GCI57+R+12aTtCN83ljF9frB+yVeMThLR
         dEgufLrMne0S7v/EfxXJSlTGqi21kcS6SzGrESM1CZ9juXAbLoeZeVgLzmSROl8KGq3T
         geWXtqhTmwsAkeyYdGGSFf64wZKh/n88ZlofYIGwzOPrjkUry3DvWtBupS6rJsQnrvpa
         wrUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773699172; x=1774303972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=nXFirVf+3TZ7nayCWf+YAe8f5IxUtczrfP1EXNbBIrmwKiqwYyLnNpAauLND8FQtug
         qyiFy+esPMVr68OOOX82lIQLtv4g9BlFNZaBwo4KsXwCVqnfA/cnHzxN3Su9BCI72YRq
         auyRj61mHF94yEemJmjWC/U+E7H+3VcjkmPSPrWbYeT/sNINXe1KOC5DtsQxJjPZdVBP
         hNMRzTNBiyInnITmm9ONHtYXDRin1mMnPr1z331IK2KJiXXPmzS1yp1rdXfeMlAWA2Ci
         qg4RD1I8Hp+NegL76P7aa4Y8Cgz6Ykhx1YR2At11/HUaYDUKWkEbjQlI4WP+iffGCmKo
         wGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773699172; x=1774303972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAPcwDRyDaYRxv6m5ec0p6vencyIfyK+pU3obaup7wA=;
        b=astmrgdSspHCdgvqcPGG3yLXpZhfQIXI77yHIYJ/yO8v/DvuhcaQipHPbgLU35XheN
         18DtsY83OfdunXVtW0jZdltFKL9aUoQFA8+mgxKUe+xViklxKcyw0khkvq2RubGPqb/F
         /owZEgAu+mW1RRpBd+pkxx1KuLZyiK5gu6CiovCILIP4n8soxUqZPlpqtr7MSWvhzp7e
         6e3w9Y3mdN757GOjuIojW2Z8KuJu/aBne62D5r/DI22w+GjsPKnobfgnTg2RMmYrRZB2
         54TJyBHTqnDPBsr46HHQevUgt+KvNv+4jwDgjuiYaWu/+AdFIc5ca1JyNamH48S75fuw
         OQHw==
X-Forwarded-Encrypted: i=1; AJvYcCXUj780tyrgmOF7AdvlEM7scY0EZotktg3d47jG8QpePVP3V3ALhlbkJgVDJdnyYbqnKWzebHBi8SIM@vger.kernel.org
X-Gm-Message-State: AOJu0YwSMdCgbAUI+IqKh4X/HGhQaIiuGXNXrdsWizpCOPkWR6cTIsUi
	VuaGXqbOSSJYBpXq7mpyYvD1bQC2G15KpYzSPoHDFS5U628sSK2tZltwsz624c/Fz2zLKJ1Yt54
	SG/aqsyVmmdBScR84BekgtxQ4EiE5PPk=
X-Gm-Gg: ATEYQzy+f0KVI+u46FqqAuZDKUub0dQuFMBn3px+jNDBhA3rqSzxLRaQpD1rBGAdcxs
	NiObYQLDNankF12J0Gf1O4/zV37533+jdwGNJgLWnydNBcBxwOP8ZncEkUus93VwpjJMGNLnIR9
	cxOZohPBMXSfYSt8Id1MaE6J+RgyEoD5D2sREQ7gToQ9A6RGRXnWW74N16GVGipgu6qq30XyQ5G
	70436ZsOh6Sp9msifEqEpqL7p9hsjnQO9LtTU8X9pj+DwTOKfW4++6Z/OFREKs4Ei4dQJB55Slk
	vDgB2m01ZK3gzzHLaFq+VuoTIDSMOTW84pwzSK3h
X-Received: by 2002:a17:907:1c0b:b0:b97:b515:31e with SMTP id
 a640c23a62f3a-b97b51509acmr346111966b.50.1773699172087; Mon, 16 Mar 2026
 15:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311070416.972667-1-hch@lst.de> <20260311070416.972667-11-hch@lst.de>
In-Reply-To: <20260311070416.972667-11-hch@lst.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 16 Mar 2026 23:12:39 +0100
X-Gm-Features: AaiRm53MOL-S4iIRiZrnVZNNZCm-cfe6kMQGe2L4WL9TC_xpq_akeJ994p2lXMA
Message-ID: <CA+=Fv5QkJm8+ysx8W=ypr84oSR=rrikfk-iMMU6_xrtS1PsWvg@mail.gmail.com>
Subject: Re: [PATCH 10/27] alpha: move the XOR code to lib/raid/
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Arnd Bergmann <arnd@arndb.de>, Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>, 
	Li Nan <linan122@huawei.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-crypto@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:06=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Move the optimized XOR code out of line into lib/raid.
>
> Note that the giant inline assembly block might be better off as a
> separate assembly source file now, but I'll leave that to the alpha
> maintainers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/alpha/include/asm/xor.h | 853 +----------------------------------
>  lib/raid/xor/Makefile        |   2 +
>  lib/raid/xor/alpha/xor.c     | 849 ++++++++++++++++++++++++++++++++++
>  3 files changed, 855 insertions(+), 849 deletions(-)
>  create mode 100644 lib/raid/xor/alpha/xor.c
>

Hi,

I applied this patch and ran it on my UP2000+

The kernel builds and boots, and I verified the new lib/raid/xor/alpha
implementation using the XOR KUnit test, the test passed, see below:

[   25.705064]     KTAP version 1
[   25.705064]     # Subtest: xor
[   25.705064]     # module: xor_kunit
[   25.705064]     1..1
[   28.957992]     # xor_test: Test should be marked slow (runtime:
3.253413330s)
[   28.958969]     ok 1 xor_test

Acked-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>
