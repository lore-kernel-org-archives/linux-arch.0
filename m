Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284684CEE72
	for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573302; cv=none; b=DIMALhs2f4u/UvTMn7I9UM3rxVpKgDxKms+nRg2w4Pu9EWDboDsrpq9rU6ppLUWmmmIoMOkk2pjSs/1055IhPUjMhyWKsjuLEqcKuc5nPvwvpDITOby1ihrvMFlwRFkjluhDe87L+mlWsvzOzvHHyb89gqpqoL0nQ0bNU1NddXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573302; c=relaxed/simple;
	bh=4P7qC+xXasT5tqW1HIdTXHj2Jb2vRmNWW7F1a5iVkRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG0qBTH3uTZmZ1X3fzIpgGoUVC99AOrdos1OCof6ZBj16JQi4VneadU3xeKd5c9xbUP5xRFiYWKIZc0Xw1I39ctpqUB3IqLau2hcxDovoE2DyoFb+AiAv+pMrcoDE1s1YLUeAp+9JgkibctuBgLLTnBQbXYJlhPyFbcH5PmowfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HqWjkYy2; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HqWjkYy2"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-66de7e0bc85so3605890d50.2
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 08:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789573297; x=1790178097;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4P7qC+xXasT5tqW1HIdTXHj2Jb2vRmNWW7F1a5iVkRw=;
        b=ezgulfCGLJmiz6ZK+YfxS8sHKZOvbGo9MrT8okoHATmiSkgGNBQu3aEXfVJ9O/P5fL
         X0Pf3WjZuS9/NPI70U9OH4bdiwTmJGIw4F5x6FiSUIjZs+Lx7U1AmJH/sNy4u4vVUldE
         eoSrtIZp7W00q/S5DuCKiT1VMDQ26XPwUcCJq5C6D1kYwwls9+Tq+ltxyhhDQSM3WogG
         FTG/8kjV2GjVJLzZSQYw529xZxRTrRKxoNxbI29uOKurYaRC8dyaUkOp8SyxdYoq/WJY
         A7zZOLtoW5flrm42BYB/T6RLxuhAc9ukzAkhK8LRnJnwrbqVj45zinz0F9YsjJqLzmmt
         sH9g==
X-Forwarded-Encrypted: i=1; AKwUvBxypQn5KShJBJ29TxEnJ1c6Jd4sIOyBC1hAwuZaGmPd++eBPzzlFWfXS7GPOZIpGpC3WPMerNrmndU+@vger.kernel.org
X-Gm-Message-State: AFuF++ljVF+uAimej80nXAo/LZKDt8nn7mZPx9koEb2X17OnK/gFtixY
	ZmsePcAWNSNfbwS5Y96bslLn4iHAu4D9R5fmLm1S4NAKlxRmzxK/0I0mhOQCOuOu2gRhUbj6oDQ
	Rl3DU+fvMUQrzCOW3vkBcuv590jNrg5sihZAbgzj50WvdpmtzILCYASxTDHexzq2G2+HMebyt8N
	IDFP2oN8iMcNFYY+G0llBFSCu+U8Yhj9d6wO6igzValZanavLf+g0/FKF42td0o2EsSelzFlQFM
	CHldDrYMzvCbg==
X-Gm-Gg: AYBFou1DCm4Z4omIXZbJ2RLnpL5r7wdKnMJ2JNsJ6VFvJP8dDZpW7JBUOCS2KuavSlx
	4vZ/zS1dHV1x7+qugOz+veg+ffuUpEtzSlpYbrcFrbhlC+GVMejWEaYRttmdfVI6lhcdF6TPin+
	p+0KAZBT4Qu9IKuRJ3MFq9E8zRlZRZr9RsvpXsLdsSUIshDJiBUiKRlZ0+9ey+y0pMggYmTHDL/
	QurVton1dEOxbav3eSoXTCCx5VF3RzK/q6L3jryXYBoWUv49vclANWKqjYAXASZ1/H1q+sJ2V7O
	W7a2NA4X9xe3lJgsNt2CbktA/hDRD3FbbU3jsaGcLy2JMWf2v5cKfH0QgyoHSxQgZiUqRJBxTcL
	Ru4dKdArtTOPsj2L9lAlF/xmpVV9iTNeysglu4vH7BEPGyLetvYkbuTS33wVm9EGSler0MoK16M
	VulVcqGCmtH29pxH4EU4n+8Jk/40kBYf35NzY=
X-Received: by 2002:a53:ac9e:0:b0:66f:be14:1a2b with SMTP id 956f58d0204a3-671631be19fmr1243110d50.11.1789573296535;
        Wed, 16 Sep 2026 08:41:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6715f73d289sm161911d50.5.2026.09.16.08.41.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2026 08:41:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3a27d89a894so25676641fa.3
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789573294; x=1790178094; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4P7qC+xXasT5tqW1HIdTXHj2Jb2vRmNWW7F1a5iVkRw=;
        b=HqWjkYy2MPi7BGiFyM6kC3IjdJtGPjw2UqYDoT6/FMwdrnK2DCuTh+IDsSeL8msGxN
         MVEUvZMEJJdP+cEnmkeRQ/kbfBmyYULsMUhaC16eOPNm7vCo6TomEeAyd1FyoZg4jWMH
         YmBUeDNSKDWxZONF/Aiv0BZg3h5kECHwI8eHg=
X-Forwarded-Encrypted: i=1; AKwUvByeBbGYz+o1ejDEvc82O9jaedh4lwlnGirRghblli2edCvz95ZTO/eUQ5aaRgMlXCa8A6PASvstKwBM@vger.kernel.org
X-Received: by 2002:a05:651c:222c:b0:3a3:42cf:c014 with SMTP id 38308e7fff4ca-3a5dc988ee4mr6734841fa.7.1789573294649;
        Wed, 16 Sep 2026 08:41:34 -0700 (PDT)
X-Received: by 2002:a05:651c:222c:b0:3a3:42cf:c014 with SMTP id
 38308e7fff4ca-3a5dc988ee4mr6734611fa.7.1789573294062; Wed, 16 Sep 2026
 08:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789488039.git.zack.rusin@broadcom.com> <aqqGUAX65s4LdJkr@thinkstation>
In-Reply-To: <aqqGUAX65s4LdJkr@thinkstation>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Wed, 16 Sep 2026 11:41:19 -0400
X-Gm-Features: AcwNN1X8EphbssgNJGAU5J8Ew6yzojuFKn8poYC7Vw-gA-ySadQxgIJcWpvSrQw
Message-ID: <CABQX2QMAfszf3z+Auo0AdwGsf94kTX0DrTrd8k6G1PTNMYsdXQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] x86/vmware: Share steal-time storage in encrypted guests
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.makhalov@broadcom.com>, x86@kernel.org, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux.dev, 
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, 
	Christoph Lameter <cl@gentwo.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008b691d065b9b80bb"

--0000000000008b691d065b9b80bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 8:18=E2=80=AFAM Kiryl Shutsemau <kas@kernel.org> wr=
ote:
>
> On Wed, Sep 16, 2026 at 01:05:38AM -0400, Zack Rusin wrote:
> > VMware registers each per-CPU steal-time GPA with the host. An encrypte=
d
> > guest must first convert that storage to shared memory, but the existin=
g
> > setup publishes the address without conversion.
> >
> > Patch 1 makes the decrypted per-CPU section available with
> > CONFIG_X86_MEM_ENCRYPT, including TDX-only configurations. Patch 2 defe=
rs
> > encrypted-guest setup until allocator-backed page-table splitting is
> > available, converts every possible CPU's storage before publishing any
> > GPA, and attempts to roll back all conversions on failure.
>
> I acked 1/2, but I don't like where 2/2 does the conversion.

I saw that, thank you. Since I'll be respinning v2 of this I can go
ahead and drop the unused DECLARE_PER_CPU_DECRYPTED in that one if you
want as well.

> A variable declared with DEFINE_PER_CPU_DECRYPTED() ends up in a
> dedicated, page-aligned linker section. The point of the section is that
> one place converts it. Instead every user does it itself: KVM in
> sev_map_percpu_data(), and now VMware in vmware_decrypt_steal_time(),
> each with its own vendor checks and failure handling. The macro today
> only buys page isolation, not the shared mapping its name promises.
>
> The underlying problem is that the whole "decrypted section"
> infrastructure is built around SME/SEV and was never generalized.
> __bss_decrypted, early_set_memory_decrypted() and
> mem_encrypt_free_decrypted_mem() are all under CONFIG_AMD_MEM_ENCRYPT
> and implemented in mem_encrypt_amd.c. sme_postprocess_startup() converts
> .bss..decrypted only if sme_get_me_mask() is set, so a TDX guest never
> shares it. 1/2 moves the per-CPU linker section to X86_MEM_ENCRYPT, but
> nothing that would act on that section follows.
>
> Rather than have every TDX user reinvent the conversion, I would rather
> see the infrastructure made vendor-neutral: boundary symbols for the
> per-CPU decrypted section like the ones .bss..decrypted has, an early
> conversion primitive that works on TDX as well as SEV, and a single
> conversion of both sections at boot. Then sev_map_percpu_data() and
> this driver's loop go away.
>
> > TDX's conversion callback uses __pa(), so patch 2 preflights every poss=
ible
> > CPU and leaves steal time disabled if a TDX guest uses vmalloc-backed
> > per-CPU storage. This covers percpu_alloc=3Dpage and automatic allocato=
r
> > fallback. AMD encrypted guests support those mappings and are not rejec=
ted.
> > Supporting them in TDX would require a separate conversion-API change.
>
> Refusing vmalloc-backed storage on TDX is the right call, and not because
> of the __pa() in the callback. Converting a vmalloc alias means either
> fracturing the direct map or leaving a private direct-map alias to a
> shared page, and the latter is a guest shutdown the moment
> load_unaligned_zeropad() steps into it. See the comment in
> tdx_early_init() and the earlier discussion of the same idea:
>
> https://lore.kernel.org/all/xqi2bkulnhen2vax5msbzczlaywx3dsc7ezpn7oo5qn7u=
7xzap@xmaseinov7tf/
>
> But that decision belongs in the same central place as the conversion.
> If the first per-CPU chunk is vmalloc-backed on TDX, the decrypted
> section is simply not shared, and users see that, instead of every
> driver re-deriving it.

I went through the linked thread, including the dropped 2022
Quote-buffer alias approach and the 2024 netvsc work's kexec
regression, fix and re-review discussion. I will keep TDX vmalloc
support out of this series and correct the explanation to cover alias
consistency, direct-map splitting and load_unaligned_zeropad(),
including removing the suggestion that per-page GPA lookup alone
resolves it.

After tracing the boot paths, I think there are two distinct pieces
here. The SEV boot GHCB needs .bss..decrypted before BSS is cleared,
whereas the SMP per-CPU instances do not exist until
setup_per_cpu_areas(). KVM then registers its boot-CPU per-CPU buffers
in smp_prepare_boot_cpu(), so the common conversion needs the early
primitive you proposed. A shared early_initcall would be too late for
KVM. The UP registration path probably also needs handling separately

My suggestion would be to do one of two things (or at least I think
those two options are realistic to me, given that I'm no expert here):
- add the central per-CPU infrastructure and migrate KVM/VMware
together, removing both loops and putting the TDX vmalloc rejection
and readiness state in common code. Would you and the KVM maintainers
be happy with that first, and generalizing .bss..decrypted separately
while preserving its earliest SEV setup? afaict the latter also needs
to broaden the annotation and linker guards, and changes kvmclock
storage and sharing on TDX-only builds.
- a smaller VMware fix using a separately allocated, direct-mapped
page per CPU while the common infrastructure is developed. Using the
normal allocator would also defer ordinary-guest registration, unless
I kept their current static storage as a second path. This option
would retain caller-managed sharing and buffer lifetime handling.

The second option is, of course, easier for me, but I'm happy to do
the first to get steal-time storage working for us. Do you have any
thoughts on this?

z

--0000000000008b691d065b9b80bb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEING+
tS9jluKZG2ayZ4pYr4+TXQr15tnm2U0384jZyaB7MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDkxNjE1NDEzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAERfaMiK9lV59M5q+bby1yJjL1JGbm82r1WysKwN
42HfcU+f5icO6ZSo7QXtjHkaqwlAJ9t0g7konmxROFmugwQJPnPsHnyImhDKDrl+oivjaTRVkWS8
SdYzaRWfwmP4lnIvc2smlzOlRUQ4yX91/Ya8N2RM5xlVI9+ajmNazilrI3OX6iar0mdW1Yd6sSnu
fnFtCEoNQf5xKtolWeoz0/9/602yXJpo096Hmu0yltMr3jSADr7PFcBDtC/ASXtQnXckfhJbLLdT
EFghfqsJMxzmXFbVwQePKR758XhTWfj7CXFmUaIUnNHYID7mVzTk2x8yH5Q6hLNOegg85bmOf24=
--0000000000008b691d065b9b80bb--
