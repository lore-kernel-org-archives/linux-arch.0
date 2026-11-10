Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330231;
	b=1FCYLdqlRXvRdr8zlMbOjX/OdIq8G2nawknpvYYu4nRmjePa/Q5C2lT6hoPZXsYZ7HFQ
	 g6/9VeA3ApUMzqlIJakJisH96J/1aSmDbo/VT2VgCpfD3Ha4w46ILs5WImmSJwPzUALo1
	 fr3H15xGLNMd0EDgQ0UzaYyrkKZw1zhrUewP6GfF8Viv10TpQwg8FZi+5wcJFWzMQobQq
	 emM8vy4m8xW/SOgD9ysxUjP53VXDAwSorIwP+ZjEmu6QdwosYLcNMBEzmSlwW9bEX5bjM
	 Cs1n3oOlYTqECvgtFDQHji/jkvl22H9QSAN7jEX/OV4Hw/k+9v05acH87tGz31U7x+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
	b=EIgrY3OWdyPPL1vMlIbXbaG7VKrC0ZRAwcFHibfWbKD34WO/rmXBWnN/ta2eM87Nvq9H
	 YlZhIt6QMCaMT9s84eGf715ZPmm5ONDqQU5jraAbpf4OPWX5tNgWRIAgnwEhvGj3B1pBa
	 eH3HNJzdRo2GRmzdS4Nw6wx2aZpFkmI62DxEPIwnXmXj1Mq5aZBk0zVhIqoWFBlk4DGcf
	 dhHXG12/Vns0MNyjdtcCHWIoJQwf+b8NA6B3YzZPi/34ngACsLyyjP9qf7L1TFsloe92f
	 ulzE1ZR+hl2hwU7YjX1S32+GaP0Z1i5mvHltyueHLyFWoYa+4+NwZpnwpwFUg3lMVCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqqEuFk0;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A9606A320
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C5A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CqqEuFk0
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b0e61a4decso1708135a91.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 09:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330231; x=1794935031; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=CqqEuFk0AQlgr0+Pai0aviiooV27t9niWrHV+H8eRhc+6PHDFeXh1X96vJxa/Dt36f
         f5Yiz3snbFS8BnY1j43shKrs+nTnOuO5TOpWAK7YB+Leh5xsUkN2q5DbPCq8EWLyDMiy
         SzPOWc1tlmmFvklAq6qlbkiOasGwfDLouqOFbi0kweOwsAx2q/xRkmpeKCHL1pjwIiGj
         wwWVGLFDXcV06SGp6Uhov/nBULclJ3h1Qlve99omyE4gY7ugTdgLPim71rZ86HGq12iZ
         6lYJrUjctnrF2QxlZ+pOeh5J+gK8+JpQT7MfqqujhOFhX/ZmgaHszxt7/F3aM+6Ikrlq
         SbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330231; x=1794935031;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqBeli1UK7UsB0colEXax3/fZJsEEio4CkgX2Fv7UF4=;
        b=ngzsZ8bpNuQ/z1aTW04Uw7k0UEf3eUc9XfE2IroXPmCQ2FHHMTjyCErxRcVPRVTwTD
         Zl3UiWFoq7F/0ZfUP2ooI9eqNkK9ZxVjkdI+N4B/zwZWL2+nfRORHZ4iFjNq8SmBP4Ki
         O9qwtwaAcN7fRRbrREQYFZfgXWxcxKKizzdfS6OncnC92eH6lECpdlRNF/jSwOO/qksm
         iT6iiJxTx4dm2sCJM8aKLrGmJIPIOXS/Rnae56OA0EJoj6z9EeC9+uOIiBUih7UYscc5
         I6NAQ/ExBKtKsp4NxlpHjB9Eoo/9OjytkbDG51gNKdOOOuCy1+Cb/CT75W9Khfqo3RMy
         sI6Q==
X-Forwarded-Encrypted: i=1; AL+hErH3zVIS3WRyuT5h14u2OzMXDT05OYKrp3kxKB+lKJBTmbBuN66eMh172kcwsOSsNqtEFLpX3jeAge4l@vger.kernel.org
X-Gm-Message-State: APuU4Z8Z2QEIzeQjJd9mj3t3h+/z7vgATt724ZLnbHgy2OYEotRYp2zX
	xoRcjOTgD6SzTqasgyv34eOCfFERDA/pMKwKJMd3Kdk6FLpvmGhTjbWbFt5qRA1THw==
X-Gm-Gg: AYBFou1D/Y0pqw+Nq40+MKiJkvW7NXXUlx48SN6nmL5KZExJjYrnIzLtrP9f9W8pkyT
	lWgC321jEd8p/1O0SCCU/6ny9XK58VTqiH7+5/wP/yvfDjhPeOSKuWf23mT3aTHH5avw+0yQ5ku
	2Ac6SYhdKg2znLEridaNAnMOLnCN0FwDiQBx5SStCpxtWFYVFbhfWChyHFYRnYukBiAU7GmraFW
	kNbDORl4m/gCU4guZAKquRXt/p9HumqFvnhbLkf3bo9H0p8DV/U3SKxHQDNLmJn/0xtL6eSx0Zx
	9cnf8caih9wPsfm4uY95orc9Rxk7vrSVDt5bXEe84xz2MYG+mWq/5A8Hb3rU+Vdh0ByPsPOZuOq
	Y1nmXQl1Nqs5UnchYWos/MLcXOF1uOb1VhW446g4HwKxEeH8bxVJ+qkdyp/ZeB4RZdyzJyytXV7
	LhqRiCBTzzJQDXNsWwzCa/IXt79eyOFoP2UqLNrLN5E6WcU/bxiCiedGMTXi/hUuCKu7cOeZ/Kn
	/QK1lLMwU0aIvNM13asQox8DTSO0LVkoSy4Odlp9i00EBr9dQgxTzkgwCs63FqKXcSVmSHcLH5f
	g8GT9UUpA2ocoUSeXYsdRNr1BI2tjj2uIE3YMh2VooqUHSj8Oudy9Gd6YSwUI4QC
X-Received: by 2002:a17:90b:524d:b0:3a6:e901:e79b with SMTP id 98e67ed59e1d1-3b166cc14bamr3213232a91.15.1794330230055;
        Tue, 10 Nov 2026 09:03:50 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm514293a91.14.2026.11.10.09.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:03:48 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 17:03:48 +0000
Message-Id: <DMROZB8DPEWD.W2BFC7JIBVZP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,

Since the entry size now comes from the block headers, incoming block
sets should not take an entry size at all. I pointed this out on the
PCI patch (16/19) as well. As is, every incoming path still calls
kho_block_set_init() with this kernel's (outgoing) entry size, which
kho_block_set_restore() then silently overwrites. That makes the
callers (e.g. pci_flb_retrieve() and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size. kho_block_set_restore() should initialize the block set itself
from the incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

Please also add an accessor for the entry size, e.g.
kho_block_set_entry_size(). Users of the block set need it to check that
incoming entries are large enough for the fields they read, and that
the fields of a feature are within the entry.

[...]

> + * Each block header also records the size of its entries. A newer kerne=
l may
> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.

KHO blocks can't guarantee the last part. The iterator returns a void *
that the caller casts to its own struct, so it is up to the caller to
not read fields beyond the entry size. Please document that callers must
check the entry size before accessing fields that may not be present.

