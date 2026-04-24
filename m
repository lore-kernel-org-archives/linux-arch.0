Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DF3BAD85;
	Fri, 24 Apr 2026 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033283; cv=none; b=gE0EFuHKO8GjEEOc3suxEkh0iTvDH3G1wp5ImOfGg8InNE5Zsd85QKizI5ulWJsVjElMcWXQQx4v+Aiqh+ej+RtJoHzTRR/tMvSvvws3sTF1NdOLscPK1JqMFWigmnFhEK3tmy5uuJ8PWk3jinLHBXHdZViNDn28v4S1sQMX/x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033283; c=relaxed/simple;
	bh=ae12Dx1GP1nt/ZBN0pu4+BdRD8YdZHY9YSVa9HGmjY4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cR1F4qzMazRe9+kwPvjT0CM2VYnJ15KtMkSWznQm+ZFnfiyq+DrNJRHfmp90QH5x1Vh0gLwUDhkJvr36GqZKwu/+PcXkl8a9ySbxr6cIt3si5jF+7j5hFIOGxOEEduVf4ebXec+h6XeQ3YmGJ8pMI8LTBFYhCjknZsyacfyZQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lQAqpc02; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lQAqpc02"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777033282; x=1808569282;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ae12Dx1GP1nt/ZBN0pu4+BdRD8YdZHY9YSVa9HGmjY4=;
  b=lQAqpc02441EAQxCACdF4jktlR77FjF6SgDUge3VR++e4htz3zw1lNya
   7nSsO0nYTCdJ4JgC8A3+teRkeVJ4ywQwUejg85jBMtz33kBumujnLqBtF
   RLPUh2vcQ0CEmKAeaZIFJZ7hj2YHTaBhtvSWTA/nn7I2ZF0bBf6q3oa/T
   FwwNSGhujp7JHEhYYOZ7iEFotbFBcEsBMQTjtXsT8gmzrCy8bIJe0Paon
   jz79vWKA4wIjxlqg0erHsqtVmE/8+14KG70O5RCCriZVQFnAQvEOt9HFh
   I6AW6uY9DA0G8XNJeocC1CjhZcIz8x/QUoHBw75phhUx5sahvE2hBtvEo
   g==;
X-CSE-ConnectionGUID: 8cA+UwSOQ2GmzJ1fq/SsZg==
X-CSE-MsgGUID: zFVPp0mPQjWfmD6cBjZVXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="88622050"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88622050"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:21:20 -0700
X-CSE-ConnectionGUID: Ddy2JyWkRiCTb6Lq3VNE8g==
X-CSE-MsgGUID: yrtNyG9vRgKsTS8VOCKqyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="226406679"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.89])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 05:21:14 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, Guenter Roeck
 <linux@roeck-us.net>, Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, =?utf-8?Q?Ma=C3=ADra?= Canal
 <mcanal@igalia.com>,
 Alessandro Carminati <acarmina@redhat.com>, Simona Vetter
 <simona.vetter@ffwll.ch>
Subject: Re: [PATCH v7 4/5] drm: Suppress intentional warning backtraces in
 scaling unit tests
In-Reply-To: <CADSE00+b-8moX5FkLjLs+wzyaW5dtJDMxvTT6Gu-QmDoDxJdVA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-4-e8bc6e0f70de@redhat.com>
 <20260420144702.GM3102624@noisy.programming.kicks-ass.net>
 <CADSE00JJq6fsYbkFN5hBD=-ZWsFG9p4_C55fp3MupMJQj0QCUQ@mail.gmail.com>
 <8a9c125c08206296d698c79c3d3dd6aea36a7e3b@intel.com>
 <CADSE00+b-8moX5FkLjLs+wzyaW5dtJDMxvTT6Gu-QmDoDxJdVA@mail.gmail.com>
Date: Fri, 24 Apr 2026 15:21:11 +0300
Message-ID: <4a64dbd6cff28950a7adbfe7d01ddfe93df34cb7@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2026, Albert Esteve <aesteve@redhat.com> wrote:
> On Tue, Apr 21, 2026 at 1:51=E2=80=AFPM Jani Nikula <jani.nikula@intel.co=
m> wrote:
>>
>> On Tue, 21 Apr 2026, Albert Esteve <aesteve@redhat.com> wrote:
>> > On Mon, Apr 20, 2026 at 4:47=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
>> >>
>> >> On Mon, Apr 20, 2026 at 02:28:06PM +0200, Albert Esteve wrote:
>> >> > From: Guenter Roeck <linux@roeck-us.net>
>> >> >
>> >> > The drm_test_rect_calc_hscale and drm_test_rect_calc_vscale unit te=
sts
>> >> > intentionally trigger warning backtraces by providing bad parameter=
s to
>> >> > the tested functions. What is tested is the return value, not the e=
xistence
>> >> > of a warning backtrace. Suppress the backtraces to avoid clogging t=
he
>> >> > kernel log and distraction from real problems.
>> >> >
>> >> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> >> > Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
>> >> > Acked-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> >> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> >> > Cc: David Airlie <airlied@gmail.com>
>> >> > Cc: Daniel Vetter <daniel@ffwll.ch>
>> >> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> >> > Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
>> >> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> >> > ---
>> >> >  drivers/gpu/drm/tests/drm_rect_test.c | 14 ++++++++++++++
>> >> >  1 file changed, 14 insertions(+)
>> >> >
>> >> > diff --git a/drivers/gpu/drm/tests/drm_rect_test.c b/drivers/gpu/dr=
m/tests/drm_rect_test.c
>> >> > index 17e1f34b76101..1dd7d819165e7 100644
>> >> > --- a/drivers/gpu/drm/tests/drm_rect_test.c
>> >> > +++ b/drivers/gpu/drm/tests/drm_rect_test.c
>> >> > @@ -409,8 +409,15 @@ static void drm_test_rect_calc_hscale(struct k=
unit *test)
>> >> >       const struct drm_rect_scale_case *params =3D test->param_valu=
e;
>> >> >       int scaling_factor;
>> >> >
>> >> > +     /*
>> >> > +      * drm_rect_calc_hscale() generates a warning backtrace whene=
ver bad
>> >> > +      * parameters are passed to it. This affects all unit tests w=
ith an
>> >> > +      * error code in expected_scaling_factor.
>> >> > +      */
>> >> > +     KUNIT_START_SUPPRESSED_WARNING(test);
>> >> >       scaling_factor =3D drm_rect_calc_hscale(&params->src, &params=
->dst,
>> >> >                                             params->min_range, para=
ms->max_range);
>> >> > +     KUNIT_END_SUPPRESSED_WARNING(test);
>> >>
>> >> Would not something like:
>> >>
>> >>         scoped_kunit_suppress() {
>> >>                 scaling_factor =3D drm_rect_calc_hscale(&params->src,=
 &params->dst,
>> >>                                                       params->min_ran=
ge, params->max_range);
>> >>         }
>> >>
>> >> be better?
>> >
>> > Since KUnit already has a few macros in its API it didn't occur to me.
>> > Good idea, I like it. And I guess the scope approach matches well with
>> > your __cleanup comment in the first patch. If no one opposes, I will
>> > work toward that pattern for the next version.
>>
>> There's a catch with kunit and __cleanup and thus (scoped) guards. Kunit
>> runs in ktreads, asserts lead to kthread_exit() and the __cleanup won't
>> be called.
>
> Hi Jani,
>
> Good point. In this specific case, the actual cleanup is handled by
> kunit_add_action_or_reset(), so __cleanup not firing on assert is
> harmless.

Right.

>
>>
>> Warning suppression being part of kunit infrastructure, asserts can and
>> should end the suppression too. But setting the example (scoped) guards
>> are safe in kunit tests in general feels like a trap waiting to happen.
>>
>
> ... but I agree it sets a misleading precedent. I'll stick with the
> explicit start/end API, then? Or maybe we can clearly document why the
> scoped approach is safe in this case and use it.

I don't know what the right approach is, just wanted to make sure you're
aware of this particular gotcha with guards and kunit.

BR,
Jani.

>
>>
>> BR,
>> Jani.
>>
>>
>> >
>> >>
>> >> Also, how can you stand all this screaming in the code?
>> >>
>> >
>> > Again, KUnit already contains many macros, so this use didn't register
>> > as such. Now I will not be able to unsee it.
>> >
>> >
>>
>> --
>> Jani Nikula, Intel
>>
>

--=20
Jani Nikula, Intel
