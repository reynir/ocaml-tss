(** Implementation of GF(2^8) *)
module GF256 : sig
  type t

  val zero : t
  val one : t

  val of_char : char -> t
  val to_char : t -> char

  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val div : t -> t -> t

  val exp : t -> t
  val log : t -> t

  module Infix : sig
    val ( + ) : t -> t -> t
    val ( - ) : t -> t -> t
    val ( * ) : t -> t -> t
    val ( / ) : t -> t -> t
  end
end

(** [share_byte secret threshold shares] splits a string [secret] into [shares]
 * shares where (at least) [threshold] shares are necessary to reconstruct
 * [secret]. *)
val share : string -> int -> int -> (GF256.t * string) array

(** [unshare shares] combines [shares] to reconstruct the secret. Note that
 * there's no integrity checks. It is up to the user to ensure that there are
 * enough shares, and that none of the shares have been tampered with or
 * otherwise modified. *)
val unshare : (GF256.t * string) array -> string

(** Same as [share], but if you only want to share a one-byte secret *)
val share_byte : char -> int -> int -> (GF256.t * GF256.t) array

(** Same as [unshare], but if you only want to reconstruct a one-byte secret *)
val unshare_byte : (GF256.t * GF256.t) array -> char
