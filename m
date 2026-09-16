Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370393EFFC9;
	Wed, 16 Sep 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561138; cv=none; b=kyMv/Jv8PXj+N4/L/Neof8HPNEEXAa460ZjChpv3e9fjD6qge2l4EJcIqhiqhrl5M9+6I7U3NjZIuNsvrg8+J0DoIGjZr802s4jh5OVUjSNOndWZ2LBLKzwpDBzRXDJFIdK2+RHRU3oVtO4WZGIqv6jkHtJb6sqc4mvx1nS2ImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561138; c=relaxed/simple;
	bh=6WWXK1YEgeNBV054WxjBb7B9Vj75OABXRc5yXZlGHSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+QPIXwjJG/vGBvWvNs5Ft5VQqt/OJ6N350J86VymNqdqe8Q1XzzQHPaeSZvzVaH7LKNucDCr96RtsgzA0cUZXzcxuRHy6CKW1raAE9jsy3Kbn7KM602SoXFQaZy8+wC2gGg4P8MNPWDEEH02S6KY8VLT9OilSQZl+EzNZT+tv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4f3aphR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4f3aphR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55A61F00893;
	Wed, 16 Sep 2026 12:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561136;
	bh=g3nJkuOIIREUaA/BODadsUt0oMvW89mcTSVk+TBxQTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D4f3aphRbKTCYsr2/YdXXnNmP/c0zn+7f5CJPLOJU5Ag2ihsF9YAuf/mxPe5qbWft
	 RuJi+8IW2fqsg2OF0+gmzWHc2BZ4j4PTjyLzOz6AXC/PLF6S9HdJruYCs9q1aBBa08
	 8ZHvdqKz4yosb2VOnkK+Ge5a3oc1M8xppXnjlaquXG9GOt81jNxcjCCBLr3Ao5sI/6
	 BahavSPx3iHj0YFmmT9k2mAHR+8Qz/8CGxdMyrpN7ANNhao26Bl05UJf0Ue5Rfo74u
	 /bJEB1hlV/SynllZ7gk30FFmaNk7xpCzcneGOvAY4XI56CwUaA/YCw+pHaapShTTsS
	 Z2H/oC/TGFtGw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 9C3EF1980047;
	Wed, 16 Sep 2026 08:18:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 16 Sep 2026 08:18:53 -0400
X-ME-Sender: <xms:KYmqalRLUKQ46xVHQNAqn_SpMCWEJPEnVGHPtE9pzFa946VuffulsQ>
    <xme:KYmqasdqqQzLLGbURN2ksP1011QzixMMfmpF8lNUTzKITQDDUxPPxIKCHfuAtHzHK
    HePpXZVWutif9vuPFKO5v9KU79xJFks9D-SgyH4nfh2k-fblP6MxBcb-Q>
X-ME-Received: <xmr:KYmqai4oFAoRIup95gPn3oxV9GZR0bmPcVh4y3t-o5HV8Kj-6Zg9KNTuehc>
X-ME-Proxy-Cause: dmFkZTF/htPXCt3Vp5AMDzX4aViluNR37AwoAasTR8iHLjBZ9vB+37s09E5FAj3fIBktXf
    wD7jyU9p9m8acEr6Ra3scjJrTilVkEufiTVp8kg6W1u05cirw+hDmrgiY3yqIDsNCGGy4Z
    NhlL2XmoVVdXSi7pWEyIFPv29lkrmEA3vKS966LaOo5Roq203cNGaURFEmJuo4rr3dx3pl
    zRvPBAEFOPc4BaV8VgR4olkNsATDKNUJ2aL3kSE+ZeDgohHMV8NuWlBUr1Y7gSpUtMk43S
    pHxrvHb6UYaqOu5IrjHeg8msBZNq9Ws0Y9sYF6moF2neMeMXhIcDUsNMr5TA/1SnWdrbnv
    krg8yzA58Iyw1wZU0OAObVQ8m4UiYc1907t7mzYhwQjpudg0+8QPH1YgpeY0d8JMVdr0rE
    I5cdBJmZizSGHOliBIKAT49rDuCWkjlzVhcGpA/FSylhtI2vOZ35amP2Bpu/ffULhom6KK
    mAFZrnyuq/2DovcPoXQKkstvBgE4kd6res0YrZ3TPJzPbjo01wcRbJyjyMarV3bBWIRJ2U
    /nfjKeUYZx8uSLHmxv0YkpN2OTgeBBvRg8w5ox13JY97RAKWHu1XAFS+AJFTFFrgA3BMc9
    4qUEfpEZPGPotDW9vPvWAQY4X3sf4al6PYefswJLQwFlMv/gcWohOVdYNR3w
X-ME-Proxy: <xmx:KYmqalZSh5ALRNUk-yGxJZtajzA-EP-yYLtuDHVayGKZTkMcKh7jSg>
    <xmx:KYmqalt_kssyM3YMu8dwBID1pt4VvyP-Mkj4cux8cj19ZAJNXpj0Vg>
    <xmx:KYmqamtGLQwsCpo5AynCQsRx8Mzfx9LtL8HamC26SVKkpQEEcWC-6A>
    <xmx:KYmqauptDI-qdtg3rUZiebczKcGTquH5dulg1Jd6BPm1F5o5OVxSfQ>
    <xmx:KYmqat4kHc5k7IM1jrC0PaSyoI4CLHsuMRGImK3xFqk2X2jADcQ2D4xX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 08:18:48 -0400 (EDT)
Date: Wed, 16 Sep 2026 13:18:46 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Zack Rusin <zack.rusin@broadcom.com>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH v1 0/2] x86/vmware: Share steal-time storage in encrypted
 guests
Message-ID: <aqqGUAX65s4LdJkr@thinkstation>
References: <cover.1789488039.git.zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789488039.git.zack.rusin@broadcom.com>

On Wed, Sep 16, 2026 at 01:05:38AM -0400, Zack Rusin wrote:
> VMware registers each per-CPU steal-time GPA with the host. An encrypted
> guest must first convert that storage to shared memory, but the existing
> setup publishes the address without conversion.
> 
> Patch 1 makes the decrypted per-CPU section available with
> CONFIG_X86_MEM_ENCRYPT, including TDX-only configurations. Patch 2 defers
> encrypted-guest setup until allocator-backed page-table splitting is
> available, converts every possible CPU's storage before publishing any
> GPA, and attempts to roll back all conversions on failure.

I acked 1/2, but I don't like where 2/2 does the conversion.

A variable declared with DEFINE_PER_CPU_DECRYPTED() ends up in a
dedicated, page-aligned linker section. The point of the section is that
one place converts it. Instead every user does it itself: KVM in
sev_map_percpu_data(), and now VMware in vmware_decrypt_steal_time(),
each with its own vendor checks and failure handling. The macro today
only buys page isolation, not the shared mapping its name promises.

The underlying problem is that the whole "decrypted section"
infrastructure is built around SME/SEV and was never generalized.
__bss_decrypted, early_set_memory_decrypted() and
mem_encrypt_free_decrypted_mem() are all under CONFIG_AMD_MEM_ENCRYPT
and implemented in mem_encrypt_amd.c. sme_postprocess_startup() converts
.bss..decrypted only if sme_get_me_mask() is set, so a TDX guest never
shares it. 1/2 moves the per-CPU linker section to X86_MEM_ENCRYPT, but
nothing that would act on that section follows.

Rather than have every TDX user reinvent the conversion, I would rather
see the infrastructure made vendor-neutral: boundary symbols for the
per-CPU decrypted section like the ones .bss..decrypted has, an early
conversion primitive that works on TDX as well as SEV, and a single
conversion of both sections at boot. Then sev_map_percpu_data() and
this driver's loop go away.

> TDX's conversion callback uses __pa(), so patch 2 preflights every possible
> CPU and leaves steal time disabled if a TDX guest uses vmalloc-backed
> per-CPU storage. This covers percpu_alloc=page and automatic allocator
> fallback. AMD encrypted guests support those mappings and are not rejected.
> Supporting them in TDX would require a separate conversion-API change.

Refusing vmalloc-backed storage on TDX is the right call, and not because
of the __pa() in the callback. Converting a vmalloc alias means either
fracturing the direct map or leaving a private direct-map alias to a
shared page, and the latter is a guest shutdown the moment
load_unaligned_zeropad() steps into it. See the comment in
tdx_early_init() and the earlier discussion of the same idea:

https://lore.kernel.org/all/xqi2bkulnhen2vax5msbzczlaywx3dsc7ezpn7oo5qn7u7xzap@xmaseinov7tf/

But that decision belongs in the same central place as the conversion.
If the first per-CPU chunk is vmalloc-backed on TDX, the decrypted
section is simply not shared, and users see that, instead of every
driver re-deriving it.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
