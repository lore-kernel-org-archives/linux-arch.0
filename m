From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Date: Fri, 10 Jan 2020 10:54:27 -0800
Message-ID: <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-7-will@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="000000000000a42d9d059bcda82d"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200110165636.28035-7-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

--000000000000a42d9d059bcda82d
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 10, 2020 at 8:56 AM Will Deacon <will@kernel.org> wrote:
>
> +/* Declare an unqualified scalar type. Leaves non-scalar types unchanged. */
> +#define __unqual_scalar_typeof(x) typeof(                                      \

Ugh. My eyes. That's horrendous.

I can't see any better alternatives, but it does make me go "Eww".

Well, I do see one possible alternative: just re-write the bitop
implementations in terms of "atomic_long_t", and just avoid the issue
entirely.

IOW, do something like the attached (but fleshed out and tested - this
patch has not seen a compiler, much less any thought at all).

                   Linus

--000000000000a42d9d059bcda82d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k58is1210>
X-Attachment-Id: f_k58is1210

IGluY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaCB8IDEyICsrKysrKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9sb2NrLmggYi9pbmNsdWRlL2FzbS1nZW5lcmlj
L2JpdG9wcy9sb2NrLmgKaW5kZXggM2FlMDIxMzY4ZjQ4Li4wNzFkOGJmZDg2ZTUgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaAorKysgYi9pbmNsdWRlL2FzbS1n
ZW5lcmljL2JpdG9wcy9sb2NrLmgKQEAgLTYsNiArNiwxMiBAQAogI2luY2x1ZGUgPGxpbnV4L2Nv
bXBpbGVyLmg+CiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4KIAorLyogRHJvcCB0aGUgdm9sYXRp
bGUsIHdlIHdpbGwgYmUgZG9pbmcgUkVBRF9PTkNFIGJ5IGhhbmQgKi8KK3N0YXRpYyBpbmxpbmUg
YXRvbWljX2xvbmdfdCAqYXRvbWljX2xvbmdfYml0X3dvcmQodW5zaWduZWQgaW50IG5yLCB2b2xh
dGlsZSB1bnNpZ25lZCBsb25nICpwKQoreworCXJldHVybiBCSVRfV09SRChucikgKyAoYXRvbWlj
X2xvbmdfdCAqKXA7Cit9CisKIC8qKgogICogdGVzdF9hbmRfc2V0X2JpdF9sb2NrIC0gU2V0IGEg
Yml0IGFuZCByZXR1cm4gaXRzIG9sZCB2YWx1ZSwgZm9yIGxvY2sKICAqIEBucjogQml0IHRvIHNl
dApAQCAtMjAsMTIgKzI2LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYW5kX3NldF9iaXRf
bG9jayh1bnNpZ25lZCBpbnQgbnIsCiB7CiAJbG9uZyBvbGQ7CiAJdW5zaWduZWQgbG9uZyBtYXNr
ID0gQklUX01BU0sobnIpOworCWF0b21pY19sb25nX3QgKmxvYyA9IGF0b21pY19sb25nX2JpdF93
b3JkKG5yLCBwKTsKIAotCXAgKz0gQklUX1dPUkQobnIpOwotCWlmIChSRUFEX09OQ0UoKnApICYg
bWFzaykKKwlpZiAoYXRvbWljX3JlYWQobG9jKSAmIG1hc2spCiAJCXJldHVybiAxOwogCi0Jb2xk
ID0gYXRvbWljX2xvbmdfZmV0Y2hfb3JfYWNxdWlyZShtYXNrLCAoYXRvbWljX2xvbmdfdCAqKXAp
OworCW9sZCA9IGF0b21pY19sb25nX2ZldGNoX29yX2FjcXVpcmUobWFzaywgbG9jKTsKIAlyZXR1
cm4gISEob2xkICYgbWFzayk7CiB9CiAK
--000000000000a42d9d059bcda82d--
