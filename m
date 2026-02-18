Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AC30ACE5
	for <linux-arch@vger.kernel.org>; Wed, 18 Feb 2026 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771449338; cv=pass; b=HxaZaQuOS7uqBv1qwsc5MYBTQFYJ7gCH7yARGWh/GTc6msJU7KhNCl7u1624A7Ix5MGibfHjk1XbOKusWxYzlQIx0Ab5uFZq/2dlqWaQQ7huu5Nl4fXs1sGHrbvjvOmVFyDjton5BMvTEc1PTGK1EISck65Np4sxUyoKfJkQajY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771449338; c=relaxed/simple;
	bh=rRj0SenJpAN0RnMZyyCNlY0gXCkcdwamr0et6XOE3Fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DmDyeg5SqP1/tquds0UIWOmhHUMCXqHu+sOZXea0Z77cTy9xgI+TGdDfqnWzoZ8JKGM+yxidc4xj1aX2c9k7UHU6N6uDYKej5ciS8mbum22lVTMsQgt8POYKyChd6mU/qdsRTBbw/5ot/LsyH/MB1Dga3hEt+m5rn4ixpKUxWAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZQEZMAf; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZQEZMAf"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-505d3baf1a7so28191cf.1
        for <linux-arch@vger.kernel.org>; Wed, 18 Feb 2026 13:15:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771449336; cv=none;
        d=google.com; s=arc-20240605;
        b=Xd9R0fnKhRgaqj+sydbYeYNDbwCPHyJAOyaXo4+8jQmrTnFwwU5CQee80p7stPzFGA
         JcXaF8QVHUvHi3oh+ITQJP23sd7pjFxNXWTDMYaz3HA/JLuDIogGBFBGBvxv07nmMecr
         Jr5zWUezDWZ7jb1GVMptUQuBxnnKEMrCE9SancsYyofLe000j2GcwpUNodYsgfDIqPsk
         mqeMI+cspk08CFeA61ms2+nzD4WwbVJvAKzbS4YH5HsNUgin3J32M/nePwxe8/v0XfpD
         CEu1RVdPN9UKVF/hS8+M04FZinbNy2xDclcz8LBZ6QZbt2GW6BRAh2toyhBzIVGABO2R
         6M7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nyWt6jmpEpxbIxUbwWSq7xGhP3q5AL79DAaw4TBVJcI=;
        fh=bNzxyWv/uh5GpMrreJARJcIo53b5ycVUCoL8qVcb+Uc=;
        b=QNOUC0mc06mjhI4fyOQGDfRfG2VDy46RzIIYjb4vaJhQI/5L6ijPxzJeZEFSe55sx7
         jclpwHQdhYxI3Q+/N3JedkOa7CGAfeyZxOeShWRM5sPIxwpAcSwP0wygKloLfoLQJIeO
         DFe3zdNmL6QEnZLgRROV9A+qx3JsLh4pkNa+odNS8bS6D0EPUnarD9/yfdA0BmIkEnX7
         RZQEa5DGMXPWmXobajc9ZD+JtDehHN1+BCHr8rocW5Oru/Yo2b0UNH7/8p1YZQ/NWLXd
         jtLgQw6uSyn9h+ZGo9rX9/33p1Z8TVwaiZchYgw9yDjUY47oEt1+9WL8+PH/BVzSuhKp
         /o6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771449336; x=1772054136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyWt6jmpEpxbIxUbwWSq7xGhP3q5AL79DAaw4TBVJcI=;
        b=aZQEZMAf7BzoZva2V+mZkzaFaMGn2rpb3mK5m53CyOmRRNGGJVp0yVilq7qrApzHDi
         pqo+m03MIlnLWmZ/U7MpegwG+YLCL7jD07KuKfHTbZA79Ou1ojGg4iiOKAkWo7qJEV/z
         Ay59IdzzKzIw7rq6Zh07XQbv03ITfN4uZz/KU01jRacCW07UtZjKGHNzRObLXeFiHkwr
         XDZEX8tI1Mcer9IX5GqVF7E9zLlti41UASmemOdr+JqV3vIc0a2CZUTyz2/OfUFwEh5W
         z6QuHjEXCxs3qw2AsUyQzGL/lajDAXAHfS2CFZjC54EcltCV7Y/zaJHKkstSBvDvKf6m
         GfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771449336; x=1772054136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nyWt6jmpEpxbIxUbwWSq7xGhP3q5AL79DAaw4TBVJcI=;
        b=e6CKOecmr+D3NhEKli+MlTWRu2VHj3B09owgrDIlo8uR+fkUWoW9oy5iBacphW33di
         V8dQ/YNE4x0XcUWbKCxPQNzBzW92F/dHE7ShrjcSie2VBjdVOFKT8wpwTcuRIotmhvuC
         AC4WeoAYI0+GFNDdL5SGJrKmT33VFjo872GyfvtlckAy2mdNpnuZSr6co0qpYSrdYzql
         z+NNVnwCJxZ0xvRXRV3WEZcfQ+ZgGlgorIVN9OtHCma2cRirYA0lLo67tjET9X1ihnH6
         HlV1Cp+7WwaGI2ZZQnFWhls7B6xd27rwng+teyc2H06KKdCqMeuEWYLk4I2iHS04tye7
         k9MA==
X-Forwarded-Encrypted: i=1; AJvYcCWV0AB4eDjEyPF19LRLG/PjqHdTTHYGna27Hyna/OVhTpM7YRrKdPvA411eLSLsj7dVbM0jva0Y0By3@vger.kernel.org
X-Gm-Message-State: AOJu0YxSSJhF/V1oV2TMrPtd1a98JBIhY3xx/nequ7jgJ5q7K/jre3je
	OJNO5wTAemGMIt6ffu9iisn6FQ+bnc2gdtjPm0LIMgrx6pykGX1ms+6iB8B7AZdBADq71s+Gztb
	yWZ2eWMwPtigUigsAP2sNID1J/x7fOWQiGtvXInQ3
X-Gm-Gg: AZuq6aIV99oGW/mP5cWxZC5z7JfY6anm2PlSz9m1SpHkXFYhgz07JVhyWQopNZRvImN
	vFYAppDONOZpKlGKKPU/CPJ/MozJQbQlvEsXZIMy0Kh7ukE2NABFU2gkBvJZyGEL6rPEFkMRimY
	JX9Pb3hCbynIHkHNepvLjpgK8gKp/P80ODT/awI8pOA2LAzBiVTuhlmEJ1EswQn/jNy5BYU2xbl
	T8Rmw2JK+EaRxcrKsiXZhg37qz6tzuQUMudOLJZDSjOvSnFfUy1anz73uWcTS3woFrraWxFSBNI
	X/hoFKLq
X-Received: by 2002:a05:622a:110a:b0:4f1:a61a:1e8 with SMTP id
 d75a77b69052e-506f1e5f40emr156951cf.10.1771449335076; Wed, 18 Feb 2026
 13:15:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMOZA0Kp29dCbj2KsX3XcuA77ghoxR1ANiOGdW-jDttFrYaKGw@mail.gmail.com>
 <87qzqjw01o.ffs@tglx> <87o6llwzd8.ffs@tglx>
In-Reply-To: <87o6llwzd8.ffs@tglx>
From: Luigi Rizzo <lrizzo@google.com>
Date: Wed, 18 Feb 2026 22:14:57 +0100
X-Gm-Features: AaiRm53YPA6RL6wNKKmAYIIAHTENXvhnl7I09kKTOPBbdyvI_HBSmTLOqVxRm4A
Message-ID: <CAMOZA0+HL=4WDZcZbLKybuiRZVJJj6XnfwmcB1P5RaoJb_C45Q@mail.gmail.com>
Subject: Re: [QUESTION] is vector_lock needed in apic_retrigger_irq() ?
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 9:49=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Tue, Feb 17 2026 at 22:08, Thomas Gleixner wrote:
> > On Mon, Feb 16 2026 at 21:44, Luigi Rizzo wrote:
> >> apic_retrigger_irq() grabs vector_lock, see code below.
> >>
> >> I am not sure if this is needed, because the function
> >> is called with a lock held on irqdesc, so I think the CPU and
> >> vector should be stable.
> >>
> >> Comments ?
> >
> > You're right. Any action which would change apcid->vector has to hold
> > the descriptor lock.
>
> I did some archaeology. This is a leftover from the v2.6 times where it
> was truly required. That never got cleaned up after the whole vector
> management got rewritten and the reason for the locking went away in
> v4.15. Nobody noticed :)
>
> How did you find that?

perf showed high lock contention while stress testing moderation with 12SSD
(96 vectors and a total of 20 MIOPs).  Then it was just a matter of
understanding
whether that global lock was really needed.

As for why my test caused high contention:
NVME does not self disable interrupts, unlike NICs, so by the time the
handler runs
there is a high probability that another interrupt has arrived,
requiring a reinject.
When moderation timers fire (they are independent, but  probably they end u=
p
being relatively close in time) all these reinject are called close to
each other.

cheers
luigi
