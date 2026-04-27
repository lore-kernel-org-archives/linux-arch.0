Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6E31E857
	for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327125; cv=none; b=jWHUDh52XdspKix/ZJsdYp57qk0xKCbTY4x7W1yWdnzhrkkRvgbd/45Oth9LLm6/kuJRddmpkSIoPo5FmUD+238uZVobyZnsLpiyO/bH4TTGbeyi94eGe8najhihRHAwH9dRMAt1T/ynCCRJxMipibJzCkXWloz+fKG+uYDVa04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327125; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WI6E3yYe0Kp7qubObkVKELRBsSAxexyAeRB2zTz2QO98FEwXHdWhi8eyM95LZD3BveEffWw/9QefLaFQyu7NZ7cwWMWa/EFrQq8FFHn1uKLwhUspYC1Mr/n4w0njjRATBDdziZ7hQtNBNsodz69RHOjmSi7jLYzzahOfz8W7las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hgi6EQnU; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hgi6EQnU"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso1581965166b.3
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327122; x=1777931922; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=Hgi6EQnUT5sb4GcwrYH91+PMJIBHmrndwdd95bn7vmICBQQE5JOnYUAyIqPnQwSBil
         cscIaEzz4C9GdUk267vAmUH0iC7O1N1O8epiBgOdA1C7ezRU3zmnDmr/IIq5FwHHpor3
         QbTAOrFM9Zg22rgiygJzv8pVfS+s3aIUggvWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327122; x=1777931922;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=OYRJs1eeFVXS51OK/bNjN92vFFj4MfPMv4OxhbnATiNnF6ECxHGe6FG5FuHotyTXx5
         aIVCYKXMXkN1QqILFJUS7YqB39oMM5NPKZaYZkjZWyeILP8zmUooIfvMtjaJQRsJ4ln4
         S5WBI3dxkmueX5cjU63JT4FElJrlW0Hjt8UD3LrlHQ+ZEt1mzsSQoiXOAv4J/XBTmOiW
         o2epWrx/tT4xKmGyBVhM5C2OMi1DHvvyZfE6MgSFQYqLoUhgOuLbWicDn5tlwEwl0Nwv
         iAlhORrFmUL76aIcqTnu3Q6ZFtQjiAeSSogTTyiefiW0WA3ocw4igr4YeWblFKltu3+e
         vVJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PUgzicMidYaYhBpnZk8QMo7Kgcwm8rFuj33d/72LFMQ03c/I/5ijFjv4XodlDi7jcce+U40mlJ+Yp@vger.kernel.org
X-Gm-Message-State: AOJu0YxcC7BE9darrszpXdM3bjSEqJ1QinIz0plksvVCn0LfMFwmdKk8
	SnbEYl+JKTplJJZ3uql5S7tOUJds2K/OvOMqyiXxX9qav3iJxHXPITJzsZw40nzrshtfW46A6cC
	k/G4c50ZlkQ==
X-Gm-Gg: AeBDieswSyv9XZmDEtrhqF0quJH23fZXDBO4kbi+AXxdSBirv66xPYcvhxAKJ4GpN+b
	pgt8expyVI+vTfICnWPqE/9oaTkRXD+LHAbKJKIdKxbPOv5FBra7KDQwqaTO4OrY8oP4FkMWxt3
	5wqY2+wMKI/eiJAk7fnArq2AvKE3XbMtC6sHCztBvMQeiH/o3F9L3iKdMg/JNNi3wC3R7n5j98k
	cWvSIagJme2b2XilTZK4Zd/yF3NtjoCSSRZOMkswyVBl0jrsTQLN/qfR++iiZEe59m55jQFx6fe
	uRAdEfIQYJLD5NZnxiczQN2fpwRutYODfGoMKpT5Jbx6mra6h/PdCx6ZwNOi8K79SO0nLaymZt6
	pDC4ZJGMItKHdVe4IkLIXYdAdk6vWkyUdWRqgByba6RbInDTZuUWYLJqJA6Zpciaw6vuj1CiU1E
	ssAS5ZK1vqAL7w2VCo/1qDLB0ex+RtDcXTrDRmKQGOGQqrmJgI0KtbWGycge0c4uGvArdLL9ENI
	2hHzdIyg3E=
X-Received: by 2002:a17:907:d312:b0:b9e:f58:c581 with SMTP id a640c23a62f3a-bb80443e813mr30657866b.45.1777327121955;
        Mon, 27 Apr 2026 14:58:41 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb808a35e19sm11335066b.16.2026.04.27.14.58.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:58:41 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1770757366b.2
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2026 14:58:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/BZV4mrghNKyuHrh5sE5TeiTx7cULUugAcQ2PiBM9e2WNghBd/lcnxkuq+nOCR8ngXNYZg3cgCGTK@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
