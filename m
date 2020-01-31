From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 00/10] Rework READ_ONCE() to improve codegen
Date: Fri, 31 Jan 2020 10:20:21 +0000
Message-ID: <7436.1580466021@warthog.procyon.org.uk>
References: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com> <20200123153341.19947-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728160AbgAaKUh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jan 2020 05:20:37 -0500
In-Reply-To: <CAHk-=wjC2EDquO8_kzc-FHOGGjgODOLKjswYGJAMh58zTkyX3w@mail.gmail.com>
Content-ID: <7435.1580466021.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Will Deacon <will@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

Of course, if you're feeling adventurous and willing to at least entertain the
mere speculation of switching the kernel source to C++, we could then use
inline template functions:

	template <typename T>
	static inline T __READ_ONCE(T &var)
	{
		T val = *(const volatile T *)&var;
		return val;
	}

	template <typename T>
	static inline T READ_ONCE(T &var)
	{
		T val;
		compiletime_assert_rwonce_type(var);
		val = __READ_ONCE(var);
		smp_read_barrier_depends();
		return val;
	}

Of course, that would mean using C++...

David
