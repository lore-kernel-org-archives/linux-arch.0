Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628330D403
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 06:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790921198; cv=none; b=GV76Ps1URwNu3mhusS6Y8NWNowez61MT12Ip2yVDLPz+90pBnkEPocO7MaDeFnmkDxCs0Yh4oy6BaM9LTZr/sZboyMZMZuF+ombbJaPuJspkxvjCPwL3X8ftlS8zpiExPqwnIIVwAe/cpSaGENiPSJ/Kvbki774fpokPzywu/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790921198; c=relaxed/simple;
	bh=/f+JysdmY5QaWTror5OCKBGuXVImsbzLYwSdcarm6w8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5qU1timvEgdVrCDXKn0GZJvCkDSNFG16JRYxe3GJz3/SMc5VtOo6lZDSo43oyFfjeKUIZQcmU9LWO46wrRjTHUfdBuls1hHhixyPbQ4sUZ4nXq5l1wDvdvjE2JNpbW87axBbQfJrVuHFMu0oNxlLiWHxIMUz5WsbewRw1LH6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=N5w4v/wj; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N5w4v/wj"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-8200b55dc47so10576847b3.3
        for <linux-arch@vger.kernel.org>; Thu, 01 Oct 2026 23:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790921196; x=1791525996;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:dkim-signature:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AgDkv5az6rwiBKUnb+l6HaF8N7E5iLl0pxm3lXFvems=;
        b=xx+YBhe7qsQjdCO5MVBizeX2ctGZhrXKVWrbohuX2rc29PFEQN7uZ925ouYVBviDsu
         T2CRpqYDo7O1NGW+MR6yH4y/VhIUcdlYgPSR4I3t3BXAxsplR6Q6f4voZzxxQFxUEG0s
         o8E7Pn4xg+YVJGRenTUNr9DoTG3BEvG3xhyiVgHCbETa9RS/EWlNp49lx5v2UpejY0Gn
         IuI4sThoRhwMUtbaoiSgDeQOo+xHJy8maQl7Nlc3ZhNMBssvJA3Z8FCHc5KkLj1YZiGN
         xtAyx6RFMaqbl/T4Sd+GohhOnaSKP4uf+oTTEGJoqpbNPdezms8wrFpG3A5YRm4U2n0P
         sPtA==
X-Forwarded-Encrypted: i=1; AKwUvBx91Gfm1Y2F+EFx0TilplMyHdpyBTT8OaVVw7cdX+f+yu/fhWJ5A+z6ca90aA1CR9+L7YewL2HGp82T@vger.kernel.org
X-Gm-Message-State: AFq9FYLa0XcXlzWzWVk8nJEn3pew54bdHJMRWurPDufJhsFcKnB79SFt
	CVV4tsPYtmM2mvpufBMFmlvfixYcYzdQ6wT+pyjcnIcEFBObHg22PehT36kzNT4u8/PFlyl4HJ9
	OhHh0O3/sB1oBW/uqSerVPHEEPAC5u2HiI5fjfMCpNmOrFZmxwHdiTx4yYyFVIMqi4lPp9qm+Rd
	Z/Fl2/3ozhqMLbvc6yyQPS9MDLd1eC7EWbl7OU/X2QC4qHnGQA8fjXlDO2a5PeeLlP5ZBgqHMl7
	9XOmbG8YPrs3w==
X-Gm-Gg: AYBFou1S14DasubW6W8ipqH6oS7Ktbj9ZxkVETpwWJponqYVBMAzvhpElGXqqip/Vb/
	0wUm7nsyT3V5rY64pb5MM2HTiAfrjEhdhScpH8VGretdLTKYv7Dce4cTNJa+9E+y366MV6DNXuu
	7YIlyUtmKD+PzsNK00EISNm9xNNgvaIvRob9qX1RAMxO+kEtENYmmSBHl5wYntKXh6UY2zFrP45
	+WsFWOGinNhhmyNZw+79jt3I1SO5DzD8JKBmYFXBLr66M7HV9jYYotc7XyNZttuOGYFlJ95OUVD
	w9uk0ZFRO3zl3LYSMMwmpaVd1xUZ+vMHU+A2uN9fB1p6Olh9w0YlUnKQ5uH06NqPObkACziT/+b
	AeXPdb1jKUMf4jDCyQbD6f/hoPS3iNIE9MNrlQIPl05Ag/xX5TOs4ci3SPj6fRjtbEz2KcVppzT
	mVbP06ePjkvkH73AiRWeS2Fr5aYRZaF7DtMj0=
X-Received: by 2002:a53:ec4f:0:b0:675:6f49:f593 with SMTP id 956f58d0204a3-677ac080a41mr416228d50.67.1790921195564;
        Thu, 01 Oct 2026 23:06:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-677ac54b1c5sm294756d50.12.2026.10.01.23.06.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2026 23:06:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34d49d8dee1so2923666eec.0
        for <linux-arch@vger.kernel.org>; Thu, 01 Oct 2026 23:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790921194; x=1791525994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AgDkv5az6rwiBKUnb+l6HaF8N7E5iLl0pxm3lXFvems=;
        b=N5w4v/wj1ko5GqrEhL24zyXdoMDN89A3/3w5bfaPOxllIVWuiQa9iN76rPgbrvwCn4
         NxhuH3JaJZO1DIAUu7/qBOcNBcMYALPZWd2VrGpzLLPkJrwmVUPQfnXMyKkpJsaXfMOA
         vGmLAxrDSHlnVJrTM2MdmunklZeV2JiMoP4hg=
X-Forwarded-Encrypted: i=1; AKwUvBzRzHv1ENM8CNrs5wBeNLuSD2oh8Zw/oED6KNXjDUnYK4zRWYibaGZeK9VEXmsuP4AFP8ff5pgfcqL3@vger.kernel.org
X-Received: by 2002:a05:7022:b88a:b0:14c:1f57:3ea9 with SMTP id a92af1059eb24-14f5bef5190mr1601631c88.26.1790921193720;
        Thu, 01 Oct 2026 23:06:33 -0700 (PDT)
X-Received: by 2002:a05:7022:b88a:b0:14c:1f57:3ea9 with SMTP id
 a92af1059eb24-14f5bef5190mr1601590c88.26.1790921192899; Thu, 01 Oct 2026
 23:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
 <20260929053930.GEartPEjbZMpBVSvSk@fat_crate.local> <CABQX2QNmza+=i1FXgDtFS3e3O5oXxPZppRbRrL54P1LmrB2gBw@mail.gmail.com>
 <20261001235950.GHar7z9v3zfk8odoTh@fat_crate.local>
In-Reply-To: <20261001235950.GHar7z9v3zfk8odoTh@fat_crate.local>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 2 Oct 2026 02:06:16 -0400
X-Gm-Features: AclHuK-rd5CcQufUaR0BIRz4PquQ50RR10S1_da_RH0Fm436Xl3eZ4up2QGuXdk
Message-ID: <CABQX2QNE331JieoHixJisyU309A-S_LDuwuZEHQf+AKQs-OyCw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] x86/percpu: Share decrypted storage before guest setup
To: Borislav Petkov <bp@alien8.de>
Cc: Kiryl Shutsemau <kas@kernel.org>, x86@kernel.org, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	linux-kernel@vger.kernel.org, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Bo Gan <bo.gan@broadcom.com>, linux-mm@kvack.org, 
	linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Long Li <longli@microsoft.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-doc@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Kees Cook <kees@kernel.org>, Ashish Kalra <ashish.kalra@amd.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a1ad0c065cd555a6"

--000000000000a1ad0c065cd555a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 8:00=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Tue, Sep 29, 2026 at 01:25:09PM -0400, Zack Rusin wrote:
> > Partly. So steal time tells Linux how much time a virtual CPU spent
> > ready to run but waiting for the hypervisor to schedule it.
> >
> > For example, during a 100 ms interval, the vCPU might execute for 70
> > ms and wait for a physical CPU for 30 ms. Reporting those 30 ms helps
> > kernel:
> > - account for CPU usage accurately: avoid charging applications for
> > time when the hypervisor wasn't running their vCPU.
> > - make fairer scheduling decisions: base task execution accounting on
> > the CPU time tasks actually received.
> > - expose host contention: the st field in top and counters in
> > /proc/stat help explain why a VM is slow even though its applications
> > don't appear to consume all available CPU time.
>
> Aaaha, IOW, that's the "st" column here:
>
> $ vmstat
> procs -----------memory---------- ---swap-- -----io---- -system-- -------=
cpu-------
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy i=
d wa st gu
>  1  0      0 1714852   9748  85300    0    0  3793    51 1445    0  0  1 =
99  0  0  0
>
> In any case, you could keep that helpful explanation in yout 0th message.=
 :)

Yeah, that's the one. Sounds good, and thanks for the links to the tip
and submitting-patches docs, I'll follow them for v3.

> > If options are binary then "no" :) It's not for monitoring tools, it's
> > for the kernel's own steal-time accounting above, which currently
> > doesn't work in confidential VMware guests. So the issue is that in a
> > confidential guest (AMD SEV SNP, Intel TDX) memory is private by
> > default, so the hypervisor can't read or write it. Any page the
> > hypervisor has to write must first be converted to shared by the
> > guest. Linux gives us the address of the steal-time buffer without
> > converting it. The hypervisor then tries to write into a private page,
> > which doesn't work. Currently ESXi deliberately powers off the VM when
> > that happens. That only affects VMs with the steal clock enabled,
> > which ESXi leaves off by default except for Photon guests. I'll
> > probably change ESXi to just disable steal time when a guest gives us
> > a private page, but that only avoids the power-off; steal time still
> > won't work in these guests without this series.
> >
> > KVM has the same need for three of its per-CPU buffers (steal time,
> > async page faults and PV EOI). It already converts them, but only on
> > AMD and in its own loop. Kiryl asked on v1 for one common place that
> > converts all such per CPU buffers early, on both AMD and Intel,
>
> Right, why early?

Because on SMP kernels both KVM and VMware hand the boot CPU's buffer
address to the hypervisor in smp_prepare_boot_cpu(), right after
setup_per_cpu_areas() and well before mm_core_init(). Sharing a page
usually means splitting the direct map around it, and
set_memory_decrypted() needs the page allocator for the new page
table. To keep that existing registration point, the common code
needed its own early sharing path, which is most of what patches 4 and
5 are.

> I mean, I am still trying to see the justification for this diffstat
>
>  14 files changed, 247 insertions(+), 51 deletions(-)
>
> and whether it is really worth it.

For VMware alone it isn't. But you guys have to decide based on what
your long-term plan here is.

I'd be happiest if we stayed within the confines of the VMware code.
That's what v1 of this did (besides the small guard fix outside) and
I'll only stray from this if I'm explicitly told that a patch/series
won't be accepted without some cleanups/re-architecture somewhere
else.

I'm here because internally we've had multiple teams needing various
bugs/features in the kernel and looking at some parts of our Linux
kernel code was making me sad so I decided to collect the changes and
use this opportunity to also cleanup some of our code. (I have three
other series in my tree, they all touch arch/x86/kernel/cpu/vmware.c
so I'm trying to push them out in a semi-coherent order.) But this is
very much a spare time thing. I can guarantee I'll find enough time to
always review the VMware bits, maintain them and answer questions
about them, but I can't do the same for other parts of the kernel. So
the more focused we can keep those patches the easier this is for me.

> > instead of each hypervisor driver doing it. That's patches 2-6.
> >
> > Patch 1 fixes an old layout bug in uniprocessor kernels, where these
> > buffers can share a page with unrelated data. The series also fixes
> > SEV and SEV-SNP guests on KVM running kernels built with CONFIG_SMP=3Dn=
,
> > which currently hang at boot (we reproduced the hang).
>
> That should tell you how much we care about UP. We would even love to mak=
e SMP
> the default.

hah :) The UP handling was a good chunk of the complexity (patch 1,
the kernel-image aliases and their kexec teardown), and the simpler
approach below doesn't need any of it.

> In talking to Peter about it, we were wondering whether this can be made
> simpler. Like do not touch perCPU but do a normal page for each CPU's ste=
al
> time gunk and thus do not split the large page and then that early
> enc/decrypting of memory I don't like either.
>
> Perhaps we should start with the simplest approach first.

Sounds good to me, that's pretty much the smaller fix I'd offered on
v1. v3 would then be VMware only: if the steal clock is available,
allocate the steal-time structs for all possible CPUs once the page
allocator is up, share them with set_memory_decrypted(), and register
the boot CPU from an early initcall. The existing hotplug callback
registers the other CPUs as they come up. The memory comes from the
page allocator, so it's in the direct map and TDX's vmalloc problem
doesn't come up. No percpu, linker-script or early-conversion changes,
and KVM stays as it is. This would also move registration for
unencrypted guests to the initcall.

One small tweak: I'd pack all CPUs into one allocation (64 bytes each)
rather than use a page per CPU. Sharing a page can still split the
large direct map mapping around it, so a page per CPU could split one
large mapping per CPU, while a single allocation concentrates those
splits in that one allocation. And that only happens in confidential
guests with the steal clock enabled.

Kiryl, I know this is the opposite of what you asked for on v1, but it
sounds like Boris and Peter would rather start with the VMware-only
fix. Shout if you object.

z

--000000000000a1ad0c065cd555a6
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIHMv
yTLPcyN7lWUhT/on8/ToZwnK+q0RgvXIiep/lGIUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MTAwMjA2MDYzNFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAFsJiP1etuKra7IRbsDCox9oIoW46luETWyadZPG
/9+VUWkP8aXivckqk369OBsHFJABXJWQE1vT4hDVOncSwlpxmcIKn1TNKt/RtfKpupSzlUej0t2v
fHZAGLORk2hFfoMgWH1ctmx5o/ssr+f+FbWsinIW1Fyp0ionq1ztT3iw8QRXNimkKo/kgnEMuvwa
mcTtsq8zD2qb4C2hCH/hvkImuzk4nYQbqNrgxE/R/ro+utG3OmZ0K3FKlqiy60hI/kd4HSSIEyLQ
Y93bjEpNzrsuP4RIsIpnA1tjPirKL7ixhTVnmZEknnbWJrgiJK7G1Nw3qTngvuoILi6Yodyvlo0=
--000000000000a1ad0c065cd555a6--
