Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6241D216
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789422292; cv=none; b=mBjI9B2K8KOrN/GXsJLyMLVKs6q0rT1IytPlgmiCqd1MRBwE8j74G3lGGSpE/zPECRNdHQH5MJBRIoX6QuWpaQnfd8EiTmCdwOIZ2D8z0+2j5yMmY+41doEcwxky+o0fuWPtA8g8LIggykvTGpkycofkbCXy5ReU9YYM0T/d0dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789422292; c=relaxed/simple;
	bh=jq28sXgMOG83pqsfn4DsTwpWb6M2x0VMwZWrEfMyIQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AD+06ze+9Z8r09YrwvJj4weZP2fiSWOPTiH8ZSjPu7cOJwl9+wABVduYQxxF+LPVgkyI2NFrJNEKu4ZisGcCI7plfV5Srrg1TdNCggRp66P9NEYV+O9ZHmfAOcwxwGTuIdlw5FAwQylb7F/bWhGovi0cxu60dSBHH+HKPTgeSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5k0jKWA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5k0jKWA"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47de0093c42so3584799f8f.3
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 14:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789422288; x=1790027088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MMWuFoZNpTbVauKFWQOZe8Q8+oQNvVLrh3IMG7Y4F/I=;
        b=F5k0jKWA5V7fsrPZW1nrHXuRGeJXyZ58u3g3QbvJYBLesJa7CsHFAcUr8F6NDqwRZg
         rldl7fTLMER31itXf6qPIcl5CK2PeJI/mtnDyg4h3IsTrxctV/75DAFB7xz+71jc8jHI
         FTSPkI6hSWQePq2HVJovw4Y0Qhbs11GUMbzc4npv+ply1DiqrpenWVxLy0/mp0QHhPPA
         apF+kSzyr+CS5A2IMOgQlxZ4/G47QCoDPsQezvtRAYpKyRE2qIQln9KxX5iMdnkqs9Z5
         4igLWbBdBqy8XCJkGoUoOGIncMjtJ7IPRa+WaIklABXnV2vaoqDENZuuSoEbc8ciwmD3
         W5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789422288; x=1790027088;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MMWuFoZNpTbVauKFWQOZe8Q8+oQNvVLrh3IMG7Y4F/I=;
        b=Q2kYG4otD45DpHqcENykA5jbjy5g0dzoOQodm7WpQ0vnekFHbsp46/M7FwR8y2gCdE
         K7o/tnaYQZxidDR39GtcpxSDa5BrODgO4hAb/hrX/CiHmbEIsfh4Xaff7fgCK0usNYLI
         sbo0nsVMd68F9vWUdCtL8ZYcokDtFShEWS8hr72B3vEb3GpTW3whgkAW54ets8h/FPIv
         ga9lTRwSXeVBGQHvSdeLwyG9iT0VQJLjmK7FZCfHYvwjk4EjzLXeLuYYf8HXg0FnXjVN
         jo1tq1skZjo/kxLt2QlEyNum9PBXj0JZ6d3AAxjrcUp4SWKgfsSmnCsumo2vvDPA9LId
         UloQ==
X-Forwarded-Encrypted: i=1; AKwUvBzKAHPw50Wm3bIbDNC4olGlUstnvsNNNjec9PQFXlEgMe7M8xk2FmD3nHosHTKYIfwh0NIFUZrP7/yp@vger.kernel.org
X-Gm-Message-State: AFuF++mXfoHyjJNdGoGkSqHqIVLnKaHXoKf5/3GPIns7pgPmsYtHls8k
	l9iJXPK3tM+0TA0m4Z55FATHqzo9EmqYx13Uhb4dy/Te2H9d74Wr72An
X-Gm-Gg: AYBFou0qoVeLDZ2tmKSIzeHVu5aZlMRyZtrS0z1wfuSUjqzLCeNaxBsxgHaLXIonhiz
	lcSgEoxOmTg7n97gex4brylHd/0mKHNFYJL+4c6ZsYGzhosikOlAUYAkHHIK7mP48wVKwgAfa1K
	Tyy44TKU2VwAvGrj/Ovmvr5E99RHbOtxJmmFyQ3L79rs1rGImyDdFKiqQKzLbfnWUL45NP/MbGq
	QxpqxS+SH98zzIzkyY2/RhK8UnMXOjqxWyF5wMRts4nPrYwGldGesHvDiNC+hTbjkm2uv6p8DIS
	UFqvZtfE3/t622bbDEYs92VyP18XHb9JzBEiPPZospzQ0SVo/6iljwInMCk+Baw5z2unwClTMzq
	S9kR4nqpvq5iINxpp66MMuw2ntFdbmszCeMnG7tsD2Ry/vi0ZP6Z5vlIl3V0chQaEMMfq1perNY
	sTsIYVYyIgjsiqE34SeGWRvnKlCJq6DtPrao7nBQr/nx7hXYY2ZIo8RQS+R3jRk6/pzTFBf3xo8
	unJbTZfHQW4az6odff2cuClgr2w36RwkAY3
X-Received: by 2002:a05:6000:454f:b0:487:36a:c870 with SMTP id ffacd0b85a97d-487036ac895mr3178523f8f.11.1789422288113;
        Mon, 14 Sep 2026 14:44:48 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ed0fbsm29878025f8f.3.2026.09.14.14.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 14:44:47 -0700 (PDT)
Date: Mon, 14 Sep 2026 22:44:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Lorenzo Stoakes <ljs@kernel.org>, linux-kbuild@vger.kernel.org,
 x86@kernel.org, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Courbot
 <acourbot@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexey Gladkov
 <legion@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Benno Lossin <lossin@kernel.org>, Bill Wendling
 <morbo@google.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Boqun Feng <boqun@kernel.org>, Borislav Petkov
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Danilo Krummrich <dakr@kernel.org>, Dave
 Hansen <dave.hansen@linux.intel.com>, Gary Guo <gary@garyguo.net>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ingo Molnar
 <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Justin Stitt <justinstitt@google.com>, Kees Cook
 <kees@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Mark
 Rutland <mark.rutland@arm.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier
 <nsc@kernel.org>, Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>,
 Tamir Duberstein <tamird@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Will Deacon <will@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-efi@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-arch@vger.kernel.org, llvm@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Jens
 Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 03/21] kallsyms: output binary data to speed output
 and kallsyms assembly
Message-ID: <20260914224432.7ed40d48@pumpkin>
In-Reply-To: <cda4d320-599d-41c8-a37f-827688b552f9@web.de>
References: <20260914-build-speedup-v2-3-39817ec5db23@kernel.org>
	<cda4d320-599d-41c8-a37f-827688b552f9@web.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Sep 2026 22:16:12 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> =E2=80=A6
> > +++ b/scripts/kallsyms.c =20
> =E2=80=A6
> > @@ -413,26 +438,24 @@ static void write_src(void)
> >  		/* Encode length with ULEB128. */
> >  		if (table[i]->len <=3D 0x7F) {
> >  			/* Most symbols use a single byte for the length. */
> > -			printf("\t.byte 0x%02x", table[i]->len);
> > +			fputc(table[i]->len, out_bin_file);
> >  			off +=3D table[i]->len + 1;
> >  		} else {
> >  			/* "Big" symbols use two bytes. */
> > -			printf("\t.byte 0x%02x, 0x%02x",
> > -				(table[i]->len & 0x7F) | 0x80,
> > -				(table[i]->len >> 7) & 0x7F);
> > +			fputc((table[i]->len & 0x7F) | 0x80, out_bin_file);
> > +			fputc((table[i]->len >> 7) & 0x7F, out_bin_file);
> >  			off +=3D table[i]->len + 2;
> >  		}
> > -		for (k =3D 0; k < table[i]->len; k++)
> > -			printf(", 0x%02x", table[i]->sym[k]);
> > +		fwrite(table[i]->sym, 1, table[i]->len, out_bin_file);
> > =20
> >  		/*
> >  		 * Now that we wrote out the compressed symbol name, restore the
> > -		 * original name and print it in the comment.
> > +		 * original name for the comments below.
> >  		 */
> >  		expand_symbol(table[i]->sym, table[i]->len, buf);
> >  		strcpy((char *)table[i]->sym, buf);
> > -		printf("\t/* %s */\n", table[i]->sym);
> >  	}
> > +	write_incbin(out_bin_name, bin_start, bin_pos(out_bin_file));
> >  	printf(".size kallsyms_names, . - kallsyms_names\n");
> >  	printf("\n");
> >   =20
> =E2=80=A6
>=20
> I suggest to avoid return value ignorance a bit more.
> https://cmu-sei.github.io/secure-coding-standards/sei-cert-c-coding-stand=
ard/rules/error-handling-err/err33-c/
> https://cwe.mitre.org/data/definitions/252.html

And I suggest you do some real coding...
The error is sticky and can be checked using ferror().
Code that looks at the return value from fprintf() fwrite() etc is very
often broken because the only time they can actual fail is when the
buffer is flushed during close.
Adding error checks to every call just make the code unreadable.

David

>=20
> Regards,
> Markus

