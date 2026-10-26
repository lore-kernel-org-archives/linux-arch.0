Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047748;
	b=PLBteO+iNQKXzDoQRuWPW4srteST/FwoZ4XLsyFgcPSKBmWRmroqr1nKZVaN1GU24tVA
	 CneZfmsSvnmnU3F0Ox5zCnKeZ0hm9rsl+QuDKmNoGf5TYGPtkGqmNbCi0pT4l0x3Otqeh
	 9ldxsLX/nSVRDf2pIYxvoqhN6zeg651m9U8RutmujRQizvuylTW4f+F7Z5dbnRMC2S/4Y
	 jV6757b2VMblUJXrIrGdtSo4LDb3Zk9KupFBGSDRuKUP/J64dVdBRSyVWvqBGR5WA05uS
	 ueycOWwQ2Da9EfriGVLBz61yXP6OJ4NVCWF3BXNuw2/nKT4xLH4Y//QWuAbrBYeuMUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=PJBAWhG3vQY26e/Nvx85KnaVoYI7FZuNNNc/vdxGNMI=;
	b=RN0I6u+NZSIYtYaM4bLWd/45hFWcYcwip98KTeeCZn9N6WRzHDg1ICSq9uc+Vi0kf0er
	 FMFSlcpmng34yO7pIWyLV0wtK7pX92TpVbIdyJeM+3rTQrYRNMX0Ygj3CDUFMoQPxY7Kb
	 b1x+SIXSB98FRUSFJ0Qf9Dh4YzObROnfc65EfHx50lt23vbZh6d/9eFs/5qfAbV8PtAw9
	 YPpgZmIT+CmpXlNp3i1ozNZfDcs9pRhEGx8/Eo3SL8qgVIlnc2OsGVkLGnh/DNYc4k/ML
	 F+ouyr8rbQ612IBqTgwEPtGIZu9tZDdh0yLrEl8VzmjjpssssMiKUvOWzNR0xeAmkMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s5LU5Vs5;
	arc=none smtp.remote-ip=209.85.215.172
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F85606A321
	for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 20:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7F85606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s5LU5Vs5
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cd5e2d696e0so1848411a12.1
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793047747; x=1793652547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJBAWhG3vQY26e/Nvx85KnaVoYI7FZuNNNc/vdxGNMI=;
        b=s5LU5Vs54/o3bJebDew/+ok9ukTsdTxy3YxxEaqaeTCk7JTg/l1sBiUXOj7U7BnuEo
         MPb7EE+a0KLYKkgIFsRnqSITcyL12B5hSr7WTSgzCG/V70XWJpbLNiSh1+NdYsPUiW/C
         Af2F+/bmOSlp+tUJTw6M+sn04E1tWQLWWENHjXZkw5aV5QIgDXidcmiozBoZIgvQY3/t
         eWxcO+Ie/jFr5h5zvZETmBDYa5UMlUTImVAPbIDCBiyA2S1r9kX1g1xvW+M25/sjwC17
         bZdBleFj6BfU4ntQ04oCQ3VyOY3iuSPkd+c0TJwZwPbI4AY0TVnE5Fz8TD3gb+lYqZRM
         UdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793047747; x=1793652547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PJBAWhG3vQY26e/Nvx85KnaVoYI7FZuNNNc/vdxGNMI=;
        b=QmGm7rPqy/sOaucSPL4AlapKHM4EhuhLuGGq5Wt/fHTf6yQdq5DT9aGkuG9SMlnDKj
         SqE6lwMOyfAwlW9ABFdnCs1ZIdQ3LO1KAZ3F5Wd/9q1b29AalRbqTkrTbqP1aB4QLY6M
         zNfDcx9MfIrt7X6Ebait1jdCfUbf7S95lir7c9XnMqWlbdSHKSpkNo637XwoFXnl1qN4
         L0TTS3U2GAkMiXCV+wi37kGbn6o4Y9eX00L3fXxV1Ro2CI2buk42I1ef9e9o/Or1qOMG
         fdohHa4SAw8jfhyVJ/sOH1s66Ed8ww0ZBdhJcJPQUQwaZpfVFtweraKI9cwD7pZ3Dgvr
         8/SA==
X-Forwarded-Encrypted: i=1; AKwUvBzfXmsVChu3Y0FJojWKXgHX3awEEP9fcw53vWiXIrN9wHCV20zfSgqlfEwhX0GG9Rb5GktKP1ZZ0tR/@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+qA/FuYjQFQtP7is0m5Qt8YkWXDnOwK4aWWXYSJJQsUktikWG
	QYNAcQYlQbGID16vX9T//JCnZQb886r1hLDTHSXhojvgEf2kVECji3P1ljmvpyXW4w==
X-Gm-Gg: AYBFou3icRLRw9u0UST5WNKgULvtEKBUm67+k+8y+rB1fQBcb3xmpG4HWFGwSW6aGSg
	1oBEfqXYPTAxakh4BKVUcPnCa5N74J21RItvf8nW6zMPkFy1thZHrJJt9BQnsw862E/yjD/EQHh
	Xhr58VAffVVXzlDHoptRWObTEYo+sE2fYFZ5D3ItYcmTIAaDq50W4xa1eV8v9b9kcCvrzxqrWdy
	44dhyRJ1qYYQG14x7Hp4trzP3GV3uyDR9qt5mTkT9dWOxYd2uLul7e1Rg6N9n0PH0YERzalNqkW
	Jf1dK0NbySjFJV4RbaHbKo2/JOIr4QytQk05vMDzbsTAbh6pgT62W13zAqmjnjimU/ipFahJwZx
	CW4G4TiQ39cEHsNg32A2H14oCfq6aJ0o8S1Fn0waLyHjOsGn8n8uE6258OmHD+zACl6M3Bnq6d7
	KPoiZKiINxyLTwK0SvPUA4UnqQqigyKxghep91+Wuyw8jCcUBXrpNtV59GdYU8NsrshRhn263PV
	EU4UIo6/OJ9DRk4eKX2CqVBHsfV1cH+cO50ZLiNkzuqJ8XVlxUj+enHgu5QiKezObqkCZEv2IRi
	J0LyCNJFV+dIK68x
X-Received: by 2002:a17:90b:5105:b0:3ac:9176:e81c with SMTP id 98e67ed59e1d1-3adeae76765mr6903041a91.46.1793047746368;
        Mon, 26 Oct 2026 13:49:06 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066aec8sm743744a91.15.2026.10.26.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:49:05 -0700 (PDT)
Date: Mon, 26 Oct 2026 20:49:02 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <at-8vkVpN2SF3XgB@google.com>
References: <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>

On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:

> > Sure but why deal with all the complexity just to save 8 bytes? All of
> > these structs are allocated on folios and there are kilobytes of unused
> > space to fit this header. And even if we optimize that we are talking
> > about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
> > sub-structs like the KVM ones.
> 
> The reason I care about keeping the header compact is that we are
> defining a foundational kernel ABI and want to use this header across
> almost every serialized data structure so we can evolve them later
> without breaking compatibility. While some top-level structs are on
> sparse folios today, other serialized structs are tightly packed, and
> we are looking to add KHO slab support in the future where tightly
> packed allocations will be common.

My intuition is we will have a small number of headers per preserved
file and per preserved FLB. One for the top-level struct and then
optionally a few more for sub-structs like arch-specific data. That is
why I am less worried 8 bytes per header, even if we fix the folio
problem.

Maybe where our visions differ is when there are collections of
serialized structs, like KHO blocks. For collections I don't think the
elements will each have their own headers. Otherwise the elements could
be different sizes.

Instead I think the struct that owns the collection will have a header
that includes features for fields in the elements. The header defines
which fields in all elements are valid. The field contents then convey
the per-element information (which might include 0 or -1 values to
convey this specific element doesn't have this data).

> That said, in your proposal, as long as nr_flags == 0 is allowed when
> a struct has no feature flags yet, luo_ser_hdr_size(hdr) is already 8
> bytes and only grows to 16 bytes on the first feature flag. I am OK
> with that.

Yeah the header will be 8 bytes until the first flag is defined, at
which point it will grow to 16 bytes.

Great, sounds like we are aligned on the header. s/luo/kho also sounds
good to me.

> > > This is not an issue on the incoming path, we never cast incoming data
> > > to struct name##_hdr or access ->payload directly. Instead, we parse
> > > the incoming buffer, dynamically compute the header size from the
> > > continuation bits, and cast the payload offset to "struct name *"
> > > based on the negotiated feature flags.
> >
> > How?
> >
> > This is the only data structure that describes the header. Are you
> > saying the incoming path will parse the header purely with a void *? Or
> > use this header but just be careful not to access payload?
> >
> > We should have one header structure that can be used on the incoming and
> > outgoing path. We should not have one header data structure that can be
> > used on the outgoing path and one that can be used on the incoming
> > path.
> >
> > Also we need a standard header that can be shared across all structs,
> > not a per struct header. Otherwise you will need to do weird casting and
> > overlays to implement the shared helper routines that parse it.
> 
> Having DECLARE_KHO_SER_WRAP() in include/linux/kho/abi/ makes it
> immediately clear just by looking at kho/abi/ which serialized structs
> have the versioned header and which do not, while also enforcing the
> header when preserving and static-asserting the combined struct size a
> compile time.
> 
> So with your header (and let's use KHO as we want to version KHO
> structs as well):
> 
> struct kho_ser_hdr {
>         __u32 size;        /* Size of header + payload in bytes */
>         __u32 nr_flags;    /* Number of features encoded in flags[] */
>         __u64 flags[];
> };
> 
> The wrapped struct will look like:
> 
> #define DECLARE_KHO_SER_WRAP(name, expected_size, nr_feats)                \
>         struct name##_wrap {                                               \
>                 __u32 size;                                                    \
>                 __u32 nr_flags;                                                \
>                 __u64 flags[DIV_ROUND_UP(nr_feats, 32)];                       \
>                 struct name payload;                                           \
>         };                                                                 \
>         static_assert(sizeof(struct name##_wrap) == (expected_size),       \
>                 "struct " #name " size mismatch!")
> 
> On the incoming kernel we don't use struct name##_wrap, but we use
> struct kho_ser_hdr for the wrapped data, validate the flags, and
> unwrap it via kho_ser_payload(hdr) to get back the struct name *
> payload type.

I still think it's not advisable to define name##_wrap since anyone
could accidentally start using it on the incoming path and we wouldn't
notice at first (especially since same kernel Live Update tests would
keep working totally fine). I also don't think asserting the combined
size buys us anything. The header size is just a function of the
number of features, and what we are trying to protect against is
structs embedded in the payload changing size.

So I would just do:

  /* Marks struct name as a KHO serialized payload with a kho_ser_hdr. */
  #define DECLARE_KHO_SER(name, payload_size) \
          static_assert(sizeof(struct name) == (payload_size))

  DECLARE_KHO_SER(luo_memfd_ser, 16);

Plus helpers that allocate and initialize the header and return the
payload as a typed pointer. Both the outgoing and incoming paths find
the payload the same way, by computing its offset from the header,
rather than through a struct with a fixed payload offset:

  /* outgoing */
  hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
  ser = kho_ser_payload(hdr, luo_memfd_ser);

  /* incoming */
  hdr = phys_to_virt(args->serialized_data);
  ser = kho_ser_payload(hdr, luo_memfd_ser);
