Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6452D1F44;
	Sat, 23 May 2026 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779538271; cv=none; b=lObyJcPdZ/7ctPu/iZcFp851O5i6392ZNpIzzAFJdw7FMmfu38HnDSc3YvnkhQxnv1DLihzwHxGQAOKHYkar5wpYtrspXkqLKbnyAMoRc5u28w3BzYt7YHcAkA3Vk7eDBeALP+WWGmdDmtvt2S/XKc/UaviJaqyTpE+ieA1QzR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779538271; c=relaxed/simple;
	bh=qB1pdubutUDrAj+S5RxmTq9ReX0YrgDD+/tMcWVo6Dg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=V4hFCdbkUuaiwQC8GKET69jg4fzAp8OS2Ymn9kjRBrAILYXj0Gi9uES0TDpGYmu/1EjMXlL0yJgBAwv40F63lAnP/2EAgWPFmna2ZL61ESjL4lDUxp+iEYqI5Tn8gI/fTBYQf32GFTfewWn7gG3L/QucoF0hYVUDxtyqD/DIDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNZozP+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNZozP+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C202F1F000E9;
	Sat, 23 May 2026 12:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779538270;
	bh=ZW7uwVrIQv9a3aYpk6kWydCgqe15Gkam/FaIQZo3eZ4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NNZozP+zmna4U/70Rd0gTULq7u3DJWRMRYTsC/ecENmKYCV2uo83MqQYNg0/WOBmd
	 A7KMRbz2jr/5fxvo6thhm63RU3RAtyit9snGc/mpMqHwbyyib45OEuScEthTYahiaO
	 W5yDTCpa4g4ismsA/yXklMOKGOUoQ7X2xcenvTTSLm1GW6Bh0AQDksap2J+4FGTpuy
	 JT9Joa9S6a9azdbkh0cSm4x1H/T6Qbt/Ffw92Vi2MQIOQk4W0nS2cdhubw5h8Kb5XB
	 /53vT+Adys6T0I6H4ducJT5Dj7m+tCmdMC3GNjcwxkUF2M0hvLbpGzeINtfe6wlsfM
	 /D7WIS26sqQzg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/7] mm: add a template-based fast path for
 zone-device page init
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: apopple@nvidia.com, akpm@linux-foundation.org, arnd@arndb.de, 
 bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, 
 mingo@redhat.com, rppt@kernel.org, tglx@kernel.org, kees@kernel.org, 
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, x86@kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20260521040124.10608-4-lizhe.67@bytedance.com>
References: <20260521040124.10608-1-lizhe.67@bytedance.com>
 <20260521040124.10608-4-lizhe.67@bytedance.com>
Date: Sat, 23 May 2026 15:10:52 +0300
Message-Id: <177953825218.3959652.8194606082469375738.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 21 May 2026 12:01:20 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 4ba506df93bc..2992711351a0 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -1066,6 +1066,63 @@ static void __ref zone_device_page_init_slow(struct page *page,
> [ ... skip 33 lines ... ]
> + * The copied template already provides the PFN-invariant portion of a
> + * ZONE_DEVICE struct page. Fix up the fields that still depend on @pfn
> + * after the copy, namely the section bits and page->virtual when present.
> + */
> +static inline void zone_device_page_init_finish(struct page *page,
> +							unsigned long pfn)

Please align the indentation for the second parameters line like int
zone_device_template_page_init() or use two tabs for indentation
everywhere.

With that fixed:

-- 
Sincerely yours,
Mike.

