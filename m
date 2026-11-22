Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795348502;
	b=Rjsp9nvXjC9/DlxxOAJBqVq9B8B4re1Ja9huSwkk6/r5iK//eO1ul+RlInNtTCW1BgJb
	 K/k+XR1CEZutsNhc0oD6Dl5cVjXtoGcZMNJypHteC+xi0KKd07Y1aTLMaIXot5cbRj81z
	 MFLFkF8CzPr9V4u3xDSkbacY2b81ntjCVctb4mzIj6XOjKY1/VvqD0sbCMzxgHXjCknQI
	 xxZQPehuYwHlcpuri+344haY5DEsPtz69hlR4fFUbxpzV7R6gR8RX9Itnq1TTpEj+G582
	 8Tr4UhCV0aWtbeku7HOqm4YQlRuwAHbAr27L17NvFIs+wr6vdTNE6vV6y7zMgYDkWdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795348502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=8c6qVyqNZ0SqHcZpSnANumyjBAiFjdYDHk+HUxi2Enk=;
	b=4LUJM/GKsYGK/xE/eZBAzAWRQwt43Hc0vybWZ/JPEwkGqwZUdW1xqmCk+cXJl4VUNwxI
	 q/9BlynXqXTq/BL290F2p8LEePQlnK3Nu2ErE3juo2J6XvBo7CcJX6ubvO2FNcbkLmrCc
	 vCln2p8UYn+ieFH+c7/PHmCZMZpRnGqor3qNqKGpL8XNomwjAlpsBiAeh0hRnmuBJVJBH
	 QdGry3q8TDtH81OniMTmIFawZ+fksqhL+5DuzOoHq0sk069uIysOH5T7BPu52jbJcyjrY
	 Drw1QO6vfcXWOXe+7LV9cOvHcBH6XNNYV6TR+LKeK5WEI5OLi0O8CYEm3F6IPCYLivw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdk7RKsm;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD290606A330
	for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2026 11:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD290606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zdk7RKsm
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48e47347279so1325790f8f.1
        for <linux-arch@vger.kernel.org>; Sun, 22 Nov 2026 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795348500; x=1795953300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8c6qVyqNZ0SqHcZpSnANumyjBAiFjdYDHk+HUxi2Enk=;
        b=Zdk7RKsmohrx5k/Al/SkovQbicu1EKXI37wI5NynMo18Bejrr9QqTge3LQUQFo4NaJ
         QShG2NRTlhn/pNf25M0pWVJck94Kex/RP6CnG8t+3Kzl7yc2Jo89ONSbSqPw/K2XgINc
         kyGcGB48KSKmJjUd+3HnNauJKhZJtQscJM2p+uPICSuBOQscn0vA3DS2YqdDXgnCIlXf
         eD3TL9LlSjCG1+MPO/RUF8otTJL1Dq7lCfFelnFxSHd9+ijeDWBdCouZxwAD/Wbqp7cD
         35PLtNOXBbDyWokVwrcgFG7sYlGWvNZtD9Hj7BblPU1I7FakYLUJ1YuJ52qDUVZUY7ha
         YMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795348500; x=1795953300;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8c6qVyqNZ0SqHcZpSnANumyjBAiFjdYDHk+HUxi2Enk=;
        b=2ayVjqPebCJi/+FdLcMzpBWR1vVGHFA5W59aSCiPD7o2AAE8/MDXu7gmfeCw6SjC7P
         IL6cDneawC3Zfmu8nvKxZfSkSqLWMGlPDG/I3evuGVfgwrd1UP87USmC6BT77e5ZYaP3
         qGGyNoCT0cgAJpTALh+XhCRxBF6VemJ8gUv+uns3rpbS5Ugp1XYmG346fauAGWQbxMlv
         l7fB14WoT5jByqijsmnEuv+voZ2s0P9u7nUTziMH66DH3qFPURW2/n7k5mtv8RPFT4Er
         BdwsypAbDewBFC4t5ho6YFONlb5rt6bzNfEatCQ7/ikC/QF1Y+7QsoV3/2/R/XVz+Mv+
         VsSw==
X-Forwarded-Encrypted: i=1; AL+hErGBsGyBDmYqHsYvMMfnFmYOLg5ULrmVZ72S36HpiNu/78FCNMERplzvr+zZOiH4QDH67CmsjQ4gfI9h@vger.kernel.org
X-Gm-Message-State: APuU4Z960I9XHgSAVYxsqQ8sx1ivunzUKHGhWsFbokJgG7SIt2X/g5tc
	xc4UGulgdx1b5ZgdgEUCoUMVqmdfClCPu6yK+nitERPv5wX/UHVO+z/j
X-Gm-Gg: AZFdTZdiI6nHTn57Hwxya6Npn3Adf9xwnS4T3glkSerG+3e8kI9WVxJiiEN6Fqm8kVT
	i8y+xKok88Pxiz4PQf7m/Y0wkSzmZuIWloG8dRp8qIgO6tVhIl9nNMeI1INmtuTcIvgLVsaeAQu
	bQQoYg/473AukoY33ugytMqWw9MaW/sCKU5xYOFJ6H5/8APD7KJRZVBt2g8SCHfW8fgXGss0cEw
	daqwH67KzlEF16oTm4ghI0uRWH1eUCvfFALJLFiJypC3ryp3ydxfsa+Lt+7ctazpIZUXlefAHg/
	nA16/jukBkljBlNnHbxzBiAgf1jcuUKrz1riOBOErUH7pqR7h1kV9Dw4LfmqpiluWzDsd96pfR7
	/uyT6dQOSUW83u7RmoTiozjCCwFxnyPuqFFXWCn8XxeVjTwkpC8JDBCrUDvxD6n6A0gW+CovsUY
	qKyLxyr813I2NMETcotNSX9QpB5kXbidVBEGAwLsFeLaxmFEFDJPEpKxvuoNhDW98mmmHIGNndM
	oOFRriG1Em0PQ3t7igA0cTLz8prCQFoTtcLHfiTdsn9hgjrP9PTsANCds/T6IP+ChYUec2qHiaY
	0v2/QcK/txFnRFg78P/A2fkDVkhAbrta+DDT9geDtewSSQsHPmzIdS5YdiGy6vYaJA==
X-Received: by 2002:a05:600c:6092:b0:4a1:d537:1c8d with SMTP id 5b1f17b1804b1-4bb8892bb67mr166647795e9.19.1795348500044;
        Sun, 22 Nov 2026 03:55:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm168516455e9.2.2026.11.22.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 03:54:59 -0800 (PST)
Date: Sun, 22 Nov 2026 11:54:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Cc: jim.cromie@gmail.com, Arnd Bergmann <arnd@arndb.de>, Jason Baron
 <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Andrew
 Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/6] vmlinux.lds.h: drop unused HEADERED_SECTION* macros
Message-ID: <20261122115458.1da4b8e9@pumpkin>
In-Reply-To: <20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com>
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
	<20261121-vmlinux-lds-v1-2-49818f3f5cc0@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Nov 2026 15:49:20 -0700
Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org> wrote:

> From: Jim Cromie <jim.cromie@gmail.com>
> 
> These macros are unused, no point in carrying them any more.
> 
> NB: these macros were just moved to bounded_sections.lds.h, from
> vmlinux.lds.h, which is the known entity, and therefore more
> meaningful in the 1-line summary, so thats what I used as the topic.

Maybe remove them first?

David

> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  include/asm-generic/bounded_sections.lds.h | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/include/asm-generic/bounded_sections.lds.h b/include/asm-generic/bounded_sections.lds.h
> index 8c29293ca7fb..268cdc34389b 100644
> --- a/include/asm-generic/bounded_sections.lds.h
> +++ b/include/asm-generic/bounded_sections.lds.h
> @@ -18,19 +18,4 @@
>  
>  #define BOUNDED_SECTION(_sec)	 BOUNDED_SECTION_BY(_sec, _sec)
>  
> -#define HEADERED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> -	_HDR_##_label_	= .;						\
> -	KEEP(*(.gnu.linkonce.##_sec_))					\
> -	BOUNDED_SECTION_PRE_LABEL(_sec_, _label_, _BEGIN_, _END_)
> -
> -#define HEADERED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_, _HDR_) \
> -	_label_##_HDR_ = .;						\
> -	KEEP(*(.gnu.linkonce.##_sec_))					\
> -	BOUNDED_SECTION_POST_LABEL(_sec_, _label_, _BEGIN_, _END_)
> -
> -#define HEADERED_SECTION_BY(_sec_, _label_)				\
> -	HEADERED_SECTION_PRE_LABEL(_sec_, _label_, __start, __stop)
> -
> -#define HEADERED_SECTION(_sec)	 HEADERED_SECTION_BY(_sec, _sec)
> -
>  #endif /* _ASM_GENERIC_BOUNDED_SECTIONS_H */
> 

