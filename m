Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FB44D033
	for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 09:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779183824; cv=none; b=hpy/RN5pk7jEe9hiBZp9s0P4IPntQpgHtAAqRITnAuquJbj9O8esz8YijEH+5oSK1hR3nR3uSBCZh9+qLXOdyOYqKkxd+wnksdbqFsr9Lmvrtnk+MyIUodEjQ0TmNJrVn0GAADic2Ml2c+98AtbxLv6T2D31Tavbyw//8fsZKMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779183824; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jupIhEGwoCvn3N4tUyK7Zbi+4qKLt8mF8P4Iw2RZOuYh2Ytvae7sxUtQZ2a0msTAUDXeWccxxpRIHCqxjUzvunOPcDr7XByY2Vcee0N19K4i78M+EjnzeRDWprBSxUo9trw+mrxnuNTmqxVKpkpyURMTu5W2zGG30oOwz/TrqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-57602a2d80aso932369e0c.2
        for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 02:43:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779183822; x=1779788622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=T8TWZDwZ6Ts/R+asqKPutwHeMtBkPUCICBNjeQVk61JbOhDCfDl1S/5ZQu3yc4rIMS
         PwH2FnydwrLAraLQvakAJZPW1wnNIQJlRT3zJw1pq8/vpM77lpOyHsvAeSvTPwbxFJ9N
         EraUmPfieMwDVNQRb6R0HQWac7BUxOj8IEa/gsyVOCKPo7A407DSXxINVzjA333Gdknr
         q2uX+q3+l+o+vAfliRbKAwguxHd/wbR/VM8bKkXb1/C+ZxEqR4mwQwGXdnUUR1Wo8kVc
         QYZggMMlVIWAGwb/Kept7enmokm9H3okN58ZTXPm70zmbqE6E7rZ6n/lvMX/vhB66Siz
         kNjg==
X-Forwarded-Encrypted: i=1; AFNElJ8bpJ1e4Urb2f2Y2boGUq+avrxTNZ901lnWXm54kWtd9Am/nogrpqzbnPAxWKk3EPbYjGTsWdLV7ioU@vger.kernel.org
X-Gm-Message-State: AOJu0YyxF6tvgz4HkUJrzf/uyZQTET5toxgn6HC3tYway0TSTc8JT8US
	dPRcy2LaMcPWWJ0WVcEDdKvhNltbpLEWwMzDPFWGwtYGTlvIt++Lbi/Ax0GIZOww
X-Gm-Gg: Acq92OGDl8AVITZtrGisxcEDuJv7/1ktMoiy1GQXIOytnNxh29xwbHD/zWT0Q2bJHFY
	9PUutXT9CD7k0hCfp0y/jfDa7NFc9pof6vRey+LxXE4iEt2F9Yu4k5uNXfewe1vyes90KvZ2b3m
	d5pOe23rTBjKkC7SlaPdsxQ7OU8VyLmMJCg/PQeCr1Q4VYxXiSs52IBce8xmRtrTrnbdjQXhmCi
	WEdqqO4x7o7a+YEGCq4A9QJargGv5UqPi9ri2NYt4tUzDDGLXnEEJ0d2l1R3RUnFO2+l7ab+7QO
	NxiJOK+ghcO5eHD0fLoNNNRWS2NqYgSXGXb4uck3KDwA64PQGKHltMqvxCvA8gW69dVx0pJFsyD
	QzZaPWkR0LTzPb3Yhjv46sCXM5dbCNAf9QrH8YCchqOVLTD2L7MWq7YUIV0ABcrT0fioE9raog/
	gvAyoxrVtWtDd3I4lSeP3QhADhSOA2hTnusok4lsxBnoAxyUHjrnAd77TUS4LWjoHSbZ69UAE=
X-Received: by 2002:a05:6122:549:b0:56f:b674:783f with SMTP id 71dfb90a1353d-5760be8bbb3mr9534209e0c.6.1779183822537;
        Tue, 19 May 2026 02:43:42 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f5cd08bsm7662786e0c.5.2026.05.19.02.43.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:43:42 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6312b8f8e47so971616137.3
        for <linux-arch@vger.kernel.org>; Tue, 19 May 2026 02:43:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/X6V77uhsmMgiVdEjNj+m8FbqmooPDTnSwiXtfKErHxY7W6Oz6/iJvwxMH57iD8yq3xkJ2GeLXVFhs@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
