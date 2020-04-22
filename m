From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 08/11] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Date: Wed, 22 Apr 2020 15:54:13 +0100
Message-ID: <20200422145412.GD676@willie-the-truck>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-9-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbgDVOyT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 10:54:19 -0400
Content-Disposition: inline
In-Reply-To: <20200421151537.19241-9-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, linux@rasmusvillemoes.dk

On Tue, Apr 21, 2020 at 04:15:34PM +0100, Will Deacon wrote:
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e970f97a7fcb..233066c92f6f 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -210,6 +210,27 @@ struct ftrace_likely_data {
>  /* Are two types/vars the same type (ignoring qualifiers)? */
>  #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>  
> +/*
> + * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
> + *			       non-scalar types unchanged.
> + *
> + * We build this out of a couple of helper macros in a vain attempt to
> + * help you keep your lunch down while reading it.
> + */
> +#define __pick_scalar_type(x, type, otherwise)					\
> +	__builtin_choose_expr(__same_type(x, type), (type)0, otherwise)
> +
> +#define __pick_integer_type(x, type, otherwise)					\
> +	__pick_scalar_type(x, unsigned type,					\
> +		__pick_scalar_type(x, signed type, otherwise))
> +
> +#define __unqual_scalar_typeof(x) typeof(					\
> +	__pick_integer_type(x, char,						\

Rasmus pointed out to me that 'char' is not __builtin_types_compatible_p()
with either 'signed char' or 'unsigned char', so I'll roll in the diff below
to handle this case.

Will

--->8

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 233066c92f6f..6ed0612bc143 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -220,9 +220,14 @@ struct ftrace_likely_data {
 #define __pick_scalar_type(x, type, otherwise)					\
 	__builtin_choose_expr(__same_type(x, type), (type)0, otherwise)
 
+/*
+ * 'char' is not type-compatible with either 'signed char' or 'unsigned char',
+ * so we include the naked type here as well as the signed/unsigned variants.
+ */
 #define __pick_integer_type(x, type, otherwise)					\
-	__pick_scalar_type(x, unsigned type,					\
-		__pick_scalar_type(x, signed type, otherwise))
+	__pick_scalar_type(x, type,						\
+		__pick_scalar_type(x, unsigned type,				\
+			__pick_scalar_type(x, signed type, otherwise)))
 
 #define __unqual_scalar_typeof(x) typeof(					\
 	__pick_integer_type(x, char,						\
