Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792631688;
	b=FkghDRsgNNxNvIGSj9S4J6EivGJj+jL4O5i3GZH4M+z8Zhnxy5/BgX1QQGO0FuXPLxTI
	 Kjeyc6GevevXjsVpsMYb87tDRYdqZ0iH6g3Z8SLmnAvYb4EJgo5g0q224tQQ4sON2jAY8
	 x5oJ5dp1kgOfE2oQGn9jkIuC3vUbN1PLNYA8lISy2MNkt3W1RDp8r0G2mLXwiJgIh18/W
	 1wmbJ422Olqu+yIYETO9RNfyK4LJPVQkSg/dRpd7byEgfsiOvcAPAq+Esvilm5idaJqDe
	 OjknovFXNRi4z5q5xXW7uD2O4HXkk4BCHIFDD2OxrT+QdkIQxGM0oM7AV7p6mc2sm3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=a8oVHE7uhvQM0uF0tb8qagzI2B8K9hhXgyXmbesBuqk=;
	b=vGClquETaDPlQzH515UyLcSngTLMBQHr2Ak0ZqCcu7yMqY96JfF45wq4xSaRQrOm9Xbk
	 HcOnEypedbg5WL2yv8a97McrcHtXXSgLhT64aY1lHefaJsIQ5krlR1zODv93G5OPKPOss
	 9dbPxHUVxfw2DCL26nDeXogdpmoPWW4Fg+KiPVzZef4lVDF9QlrBPVw0eu8+OKbL/gia8
	 4d5FDh6OcZYksDCroWTTBKtxf52yD0s1wfs+wn23MFvIZwkVtO7qzopxMvJeK+p7SoEXd
	 G1lwMzNeWh+OuGNs0SfQ34/JHuppL4w+efx3J7oOeX1yeeucdtZUbzHol5VBXqYJtmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=h4aeOYMM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DC606A31F
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 01:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD3DC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=h4aeOYMM
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0794669a6so2012164a12.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 18:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792631686; cv=none;
        d=google.com; s=arc-20260327;
        b=LUuEnVk1vImBBrCpT7VPxCn33W6Hpa+FUR3OLkNwIX7w3wK4I9cxajCKDOscQp/Vdl
         R9BkBlhuKr8jMKT6E5io+9lutE5aWBvxufTwstwCor0agdX7aEegRGQJXY6LIM4Tj54n
         hfeU3rvgfVf6nmhny31eRjI9lepV5uvNQi1ZW5BEyyW20Gvib1o/wSiefYLMoWixo655
         HZkiOYw+HC+KTnXs6pajBQMzBGyP4oCuE2OhRIBA1kUWYDppH5TeCzzaoXsigIiah8Hk
         3IObfTl45UJhufggNhx6b8NhqfYBV4ISr3rluw0GydoOdWphh23kJ7bylUXqICHrm/nh
         tyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a8oVHE7uhvQM0uF0tb8qagzI2B8K9hhXgyXmbesBuqk=;
        fh=7gOecwTW/sK4fiBNwflwQQjsBRqM7AQHqqM0XKlX4GA=;
        b=ix/1h96fjsFlebRx8YfE+u+0j6V87BR9bXeiW2SR2T312fvuULYPaRPvH3ILnXI5BO
         riRWfC+OfkfK+Nf/c1d+FRkCLAenLh3FkEzC5OlO5n8K/N4nbyVSPsg83rIU1uHiWmRX
         GNilbCJe2IlwDpkIcZbY3GhmEU37CXQtsgZJSRuqExExZPLKFvFjJXNKA7u3V86k39sw
         By3LJhXqbLaS5GbK4K9olqx/dCVSkaWVpMMdPZO0cctv1UKnfY0qe16l+f7MuaBanqp2
         szCQ8blZbxtIwq4bPWcBGG1uSrNNtE22+pB4XPrmGOWZaL1EixE1Cj8+qQglZ8HqiQkq
         N8ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792631686; x=1793236486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=a8oVHE7uhvQM0uF0tb8qagzI2B8K9hhXgyXmbesBuqk=;
        b=h4aeOYMMTxKyRYgZtsnsT3DxNu23YYAw1u34qUhRlSjeVCO1bPj8wwJ4QJmbI/Wpmk
         mCvtrETuEXZHHHYPExcPssw9U0vFNPwSjLUL+6vY43kAicvIfcWspH9bPbwlkSupYC4f
         tDhbq41Ou4QJ//OkC4ciETvL8U5bpuUErc6cmmf8D4sVIy5Z8Dcal76uchJ+nCF+1pbb
         tsJMul/0jtnlQzJUbRVS9vJEp+7n9wujrZwcgIJ5/P/RQo/RJpoW6DDj7ff7jrxlEkTk
         pMX1IImB8n4NMX5HBFvK7m0lKJVt2FDm3Xcyq0Kpdw5g2BpjXaoEfSl+w+aRpiVFzcZf
         Mvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792631686; x=1793236486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a8oVHE7uhvQM0uF0tb8qagzI2B8K9hhXgyXmbesBuqk=;
        b=OL5iB3XnqiobZQs/tF52PIJ3+07T1CNMCUb52iblGBtMM1jArvOOFAq2uRkYX5kOYq
         jY79PJrzPVO4hVgu9EM7GyW1qwbA1p17Nnr349dCCpFnzq7JloyaUMKbxUiqc0tLEX4v
         5NxzbqpfGGyhAb6Mttn0wMo2IShMu67SdXAQT2+h0LOKr0uEouYiAmy1fEVveZjPN/t1
         xP/FvWF7q2F3p7OueupfUZnTqjHd0+bRtr/YfBi4sHOO7Hss7edrtchttvSgg84LirTh
         HXubaSPrJf0nowifhHghBnP4hMdO6EMYNBnre+9LCOfz+H7rgTmGirF/dxRuUpl2DWO/
         oxrA==
X-Forwarded-Encrypted: i=1; AKwUvBwb/tB+RPDT7RnsR0gcaejakYVpOwYMdcXccSqhpjy889PTz0816fGVQbE2+4GNzGCWXsZ5HQmG2IlA@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5tTlkDP16U526BXx61ozNNIxdOAxQCrjOsJ2c6UfdtDAAlseL
	gkcDNbCl1qlPkXJxenf2PbYgksJ4DhssFP7jxjr6I0lUKE6XA6nF7QBcz6E2AFv2Nc3CJrRHZid
	22ePVbzYN0gzGeVa9ekqrKJ6W7dQZJ/UTP8r+jbS7Lw==
X-Gm-Gg: AYBFou1bdRw0Tdngqkc6wcBw50EjRhoooJMOLL/f0VDkvJFWjbAHIItcBjpYWBUcUfE
	h3VFikJ4m85qJFmQTC190782dLR5Mp/UZs558plHRnjUwa3spxLAB4OkyQBRFcyU3bo/HKfoNUN
	julDP0hrW7eTXGDSHjfmHwYoibnXrT73q8bnqf/Pfy7/oOzv3imJnvK6D9cX90mEoihZw9rBgZb
	PSkkXtFtTWrcFNhZQJdbrbt7ggTgHKK66uslXQuEsAf/dcsbbL1u4jyCxALNJYsrijdMI7Vy6d8
	njxEs+c7RNL8BvBQSjsiCrw1Ec/RQSg1pjholFC5+nKm8NDWVOyNaa5EHLQz/x5ZYD4rgrMxrpR
	lqnTTZXzTYorvkpo40wzD9JccjzCODdKnIfBXZKdWujYwP8oqq57HlrRIBlLM4mt4zu5Ud2Dze3
	7oQsp2I0FY3AXM
X-Received: by 2002:a05:6402:428d:b0:6b1:b5b8:b696 with SMTP id
 4fb4d7f45d1cf-6b408eba0a5mr2764546a12.23.1792631685748; Wed, 21 Oct 2026
 18:14:45 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-3-tarunsahu@google.com>
 <CA+CK2bCnS8wcVDbOymBGeJB6pDUkknOpF22EynbwSV=D5=J4ow@mail.gmail.com> <atlEdhPjlyTPDWmG@google.com>
In-Reply-To: <atlEdhPjlyTPDWmG@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 21:14:09 -0400
X-Gm-Features: AclHuK8ceakYR2BnO2tCnQU3MVfSYSSwRjvSGLmyMHhBXtZBiFnzxvM1Bfsv7Tk
Message-ID: <CA+CK2bAxgtx2gZ-UE2HqwAU8=h9K5RE3xozBs1njgLo1-CaPvA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] liveupdate: Select file handler by name in the
 preserve ioctl
To: David Matlack <dmatlack@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:02=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 01:17 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> > >
> > > Currently luo_preserve_file() iterates over luo_file_handler_list and
> > > picks the first registered handler whose .can_preserve() callback
> > > returns true. When a subsystem introduces a new, backwards-incompatib=
le
> > > file handler alongside an existing one for the same file type, usersp=
ace
> > > has no way to choose which handler preserves a file descriptor, nor c=
an
> > > the kernel keep the existing rollback-safe handler as the default whi=
le
> > > allowing callers to opt into the new handler.
> >
> > That is not how it will work. If we are in the .can_preserve() call,
> > it means the user has already decided which file handlers to use. We
> > need to do that before any preservation happens; otherwise, we could
> > run into conflicts on FLBs i.e. FH of different version require
> > different FLBs.
> >
> > Therefore, there should be a luoctl call (i.e via a new ioctl to set
> > compatability) that provides the kernel with the specs file of the
> > target kernel we are updating to, allowing the kernel to select the
> > compatible file handlers. Since .can_preserve() is called when the
> > user is already preserving files, the specification must have already
> > been supplied, or the kernel should fall back to using the default
> > (i.e., latest) file handlers.
>
> I don't think that is the right direction. IMO the kernel should not be
> choosing which file handler to use, userspace should be. If userspace
> gets it wrong and chooses a file handler the next kernel does not
> support, that's on them.
>
> The problem with the kernel making a decision about file handlers is
> then userspace does not know what arguments to pass in. We are adding
> custom per-file handler arguments to PRESERVE_FD and RETRIEVE_FD. If the
> kernel is picking which file handler to use, say for a memfd, then
> userspace doesn't know which arguments to pass in.

It is not the kernel deciding on its own which handler to use; it is
the system admin (or host orchestrator) that configures LUO before the
LU process starts, because the sysadmin knows what kernel we are
rebooting into and the LUO specs of that target kernel. Meanwhile, the
process calling PRESERVE_FD (e.g., a VMM) only knows about its own FDs
and should not have to track target kernel serialization versions.

Also, the PRESERVE_FD and RETRIEVE_FD arguments are uABI tied to the
FD type, not to a specific internal handler version. They are stable,
and we can expand them the same way any ioctl argument is expanded
(via size and flags), without ever shrinking or breaking them. We
should not play the game of providing completely different uABI
argument structs for different versions of a file handler. If a caller
passes a new feature in the uABI args that the currently configured
file handler version does not support, PRESERVE_FD simply returns
-EOPNOTSUPP, just like any other extensible ioctl.

> Sure you could add some method where userspace could query which file
> handlers are active and decide arguments based on that. But it feels
> backwards.
>
> I think a much cleaner solution is that userspace chooses file handler
> during PRESERVE_FD. I would even require it for RETRIEVE_FD so that we
> are guaranteed that the args the user is passing in are being sent to
> the right file handler. Passing to RETRIEVE_FD also opens the door to
> transforming across Live Update (similar to how AWS did LU from Xen to
> KVM as discussed at LPC).

On RETRIEVE_FD, the preserved metadata already identifies what format
was preserved. Validating that the user is passing the right argument
struct only requires checking the compatable string, not selecting a
serialization version on every call. And if we ever want to support
cross-subsystem transformations on retrieve, that is a retrieve-side
conversion capability.

> Regarding FLB conflicts, today we don't support multiple FLBs for the
> same global state, so there is nothing to conflict. Selecting a file
> handler during PRESERVE_FD doesn't change that.
>
> If we ever need to support multiple FLBs for the same global state
> (e.g. an incompatible change to the PCI FLB), we can add an ioctl that
> lets userspace select which FLB to use before preserving any files.
> After that, only file handlers registered with the selected FLB can be
> used to preserve files. PRESERVE_FD with any other file handler fails.
>
> That keeps the FLB decision up front and global, like you want, while
> still letting userspace pick the file handler for each fd. I'd also
> expect this to be rare, since FLB serialized state can use the same
> feature flags as everything else in this series.

Userspace owns FDs, not FLBs. Whether a subsystem uses one FLB, two
FLBs, or no FLB to coordinate state across FDs is internal kernel
plumbing. Exposing an ioctl for userspace to select FLBs leaks kernel
internals into the uABI.

Therefore, I think we should not select FLBs from userspace at all.
FLBs are an internal kernel mechanism for sharing state across FDs;
from userspace, we only preserve FDs, so that is what should be
configurable, and the kernel should resolve the dependencies and pick
the FLB versions accordingly.

Changing one file handler may require changing another file handler
because they share an FLB. We can't have a situation where one VMM
preserves using FH_A and another uses FH_B for the same FD type,
trying to use different FLBs for the same data (since we can't
preserve the same page into KHO twice). More generally, we are
rebooting the host into a single target kernel, so compatibility is a
session-level property, not a per-FD property. If we need an upfront
global ioctl anyway, configuring the target compatibility upfront in
one place is much cleaner than exposing FLBs to userspace and
splitting version selection between a global ioctl and per-FD
PRESERVE_FD calls.
